#!/usr/bin/env python
# -*- coding: utf-8 -*-

from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import inch
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle, PageBreak, KeepTogether
from reportlab.lib import colors
from reportlab.lib.enums import TA_RIGHT, TA_CENTER, TA_LEFT
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from arabic_reshaper import reshape
from bidi.algorithm import get_display
import os
import re

# Constants
SOURCE_FILE = r"c:\Users\HELAL\.gemini\antigravity\brain\162825ea-da29-4f95-8598-46152284d4e2\task_analysis.md.resolved"
OUTPUT_FILE = "docs/task_analysis_full.pdf"

def prepare_text(text):
    """Prepare text for PDF: clean markdown and reshape Arabic"""
    if not text:
        return ""
    
    # Clean Markdown links: [text](url) -> text
    text = re.sub(r'\[([^\]]+)\]\([^\)]+\)', r'\1', text)
    
    # Clean Bold: **text** -> text
    text = re.sub(r'\*\*([^\*]+)\*\*', r'\1', text)
    
    # Clean Code ticks: `text` -> text
    text = re.sub(r'`([^`]+)`', r'\1', text)
    
    # Reshape Arabic
    reshaped_text = reshape(text)
    bidi_text = get_display(reshaped_text)
    return bidi_text

def parse_markdown(file_path):
    """Parse the markdown file into a structured format"""
    structure = []
    current_table = []
    
    with open(file_path, 'r', encoding='utf-8') as f:
        lines = f.readlines()
        
    for line in lines:
        line = line.strip()
        if not line:
            if current_table:
                structure.append({'type': 'table', 'data': current_table})
                current_table = []
            continue
            
        if line.startswith('# '):
            structure.append({'type': 'title', 'text': line[2:].strip()})
        elif line.startswith('## '):
            if current_table:
                structure.append({'type': 'table', 'data': current_table})
                current_table = []
            structure.append({'type': 'h1', 'text': line[3:].strip()})
        elif line.startswith('### '):
            if current_table:
                structure.append({'type': 'table', 'data': current_table})
                current_table = []
            structure.append({'type': 'h2', 'text': line[4:].strip()})
        elif line.startswith('|'):
            # It's a table row
            # Split by | but ignore empty first/last if they exist
            # Simple split might fail if | is inside text, but for this specific file structure it should be fine
            cells = [cell.strip() for cell in line.split('|')]
            # Remove empty first/last elements caused by leading/trailing |
            if not cells[0]: cells.pop(0)
            if cells and not cells[-1]: cells.pop(-1)
            
            # Check if this is a separator line (e.g. |---|---|)
            is_separator = all(set(c).issubset(set('-: ')) for c in cells)
            
            if not is_separator:
                current_table.append(cells)
        else:
            # Normal paragraph text (if needed, though this file seems structured mostly with tables)
             if current_table:
                structure.append({'type': 'table', 'data': current_table})
                current_table = []
             # Only add if it's not a horizontal rule
             if not line.startswith('---'):
                 structure.append({'type': 'paragraph', 'text': line})

    if current_table:
        structure.append({'type': 'table', 'data': current_table})
        
    return structure

def create_pdf():
    # Create docs directory if it doesn't exist
    os.makedirs("docs", exist_ok=True)
    
    doc = SimpleDocTemplate(
        OUTPUT_FILE,
        pagesize=A4,
        rightMargin=0.5*inch, # Reduced margins for more space
        leftMargin=0.5*inch,
        topMargin=0.5*inch,
        bottomMargin=0.5*inch
    )
    
    # Register Fonts
    try:
        pdfmetrics.registerFont(TTFont('Arabic', 'C:/Windows/Fonts/arial.ttf'))
        pdfmetrics.registerFont(TTFont('Arabic-Bold', 'C:/Windows/Fonts/arialbd.ttf'))
    except:
        print("Warning: Could not load Arial font. Ensure C:/Windows/Fonts/arial.ttf exists.")
        return

    # Styles
    styles = getSampleStyleSheet()
    
    title_style = ParagraphStyle(
        'ArabicTitle',
        parent=styles['Heading1'],
        fontName='Arabic-Bold',
        fontSize=22,
        alignment=TA_CENTER,
        spaceAfter=20,
    )
    
    h1_style = ParagraphStyle(
        'ArabicHeading1',
        parent=styles['Heading2'],
        fontName='Arabic-Bold',
        fontSize=16,
        alignment=TA_RIGHT,
        textColor=colors.HexColor('#2c3e50'), # Dark Blue
        spaceBefore=15,
        spaceAfter=10,
    )
    
    h2_style = ParagraphStyle(
        'ArabicHeading2',
        parent=styles['Heading3'],
        fontName='Arabic-Bold',
        fontSize=14,
        alignment=TA_RIGHT,
        textColor=colors.HexColor('#7f8c8d'), # Grey
        spaceBefore=10,
        spaceAfter=5,
    )
    
    normal_style = ParagraphStyle(
        'ArabicNormal',
        parent=styles['Normal'],
        fontName='Arabic',
        fontSize=10,
        alignment=TA_RIGHT,
        leading=14,
    )

    cell_style = ParagraphStyle(
        'CellText',
        parent=styles['Normal'],
        fontName='Arabic',
        fontSize=9,
        alignment=TA_RIGHT,
        leading=11,
    )
    
    header_cell_style = ParagraphStyle(
        'HeaderCellText',
        parent=styles['Normal'],
        fontName='Arabic-Bold',
        fontSize=10,
        alignment=TA_CENTER,
        textColor=colors.whitesmoke,
    )

    elements = []
    
    # Parse File
    content = parse_markdown(SOURCE_FILE)
    
    for item in content:
        if item['type'] == 'title':
            elements.append(Paragraph(prepare_text(item['text']), title_style))
            elements.append(Spacer(1, 10))
            
        elif item['type'] == 'h1':
            elements.append(Paragraph(prepare_text(item['text']), h1_style))
            
        elif item['type'] == 'h2':
            elements.append(Paragraph(prepare_text(item['text']), h2_style))
            
        elif item['type'] == 'paragraph':
            elements.append(Paragraph(prepare_text(item['text']), normal_style))
            elements.append(Spacer(1, 5))
            
        elif item['type'] == 'table':
            table_data = item['data']
            if not table_data: continue
            
            # Prepare data for table
            formatted_data = []
            
            # Check headers to determine column widths
            # Expected headers: [Task, Status, Details] (English) -> [المهمة, الحالة, التفاصيل] (Arabic)
            # In the file the order is: Task | Status | Details
            # We should check the first row content to be sure, but usually:
            # Col 0: Task (Short/Medium)
            # Col 1: Status (Short)
            # Col 2: Details (Long)
            
            # Let's assume 3 columns.
            col_widths = [1.5*inch, 0.8*inch, 4.5*inch] # Total ~7 inch (A4 width is 8.27, margins 1.0 -> 7.27 usable)
            
            # If we have 4 or 5 columns (Summary table), adjust widths
            if len(table_data[0]) >= 4:
                col_w = 7.0 / len(table_data[0])
                col_widths = [col_w * inch] * len(table_data[0])

            for i, row in enumerate(table_data):
                formatted_row = []
                style = header_cell_style if i == 0 else cell_style
                
                for cell_text in row:
                    p = Paragraph(prepare_text(cell_text), style)
                    formatted_row.append(p)
                formatted_data.append(formatted_row)
            
            # Styling
            t = Table(formatted_data, colWidths=col_widths, repeatRows=1)
            
            # Determine table color based on context? 
            # Hard to know context inside loop, but we can default to Blue.
            # If we wanted red for backend, we'd need to track state.
            # For simplicity, let's use a neutral professional color or alternate.
            
            # We can guess based on H2 text if we tracked it, but simple Blue is safe.
            tbl_style = [
                ('BACKGROUND', (0, 0), (-1, 0), colors.HexColor('#2c3e50')), # Dark header
                ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
                ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
                ('VALIGN', (0, 0), (-1, -1), 'TOP'),
                ('GRID', (0, 0), (-1, -1), 0.5, colors.grey),
                ('BACKGROUND', (0, 1), (-1, -1), colors.whitesmoke),
                ('BOTTOMPADDING', (0, 0), (-1, -1), 6),
                ('TOPPADDING', (0, 0), (-1, -1), 6),
            ]
            
            t.setStyle(TableStyle(tbl_style))
            elements.append(t)
            elements.append(Spacer(1, 15))

    doc.build(elements)
    print(f"Success: Created {OUTPUT_FILE}")

if __name__ == "__main__":
    create_pdf()
