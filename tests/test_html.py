import os
import pytest
from bs4 import BeautifulSoup

def test_html_exists():
    """Test that index.html file exists"""
    assert os.path.exists('index.html'), "index.html file not found"

def test_html_structure():
    """Test basic HTML structure"""
    with open('index.html', 'r') as f:
        soup = BeautifulSoup(f.read(), 'html.parser')
    
    assert soup.find('title') is not None, "HTML title tag missing"
    assert soup.find('body') is not None, "HTML body tag missing"
    assert soup.find('head') is not None, "HTML head tag missing"
    
def test_portfolio_content():
    """Test portfolio-specific content"""
    with open('index.html', 'r') as f:
        content = f.read().lower()
    
    # Check for portfolio-related keywords
    portfolio_keywords = ['portfolio', 'skills', 'projects', 'experience']
    found_keywords = [keyword for keyword in portfolio_keywords if keyword in content]
    
    assert len(found_keywords) >= 2, f"Portfolio content missing. Found: {found_keywords}"
    assert len(content) > 1000, "HTML content too short for a portfolio"

def test_html_validity():
    """Test HTML is well-formed"""
    with open('index.html', 'r') as f:
        soup = BeautifulSoup(f.read(), 'html.parser')
    
    # Check for common HTML elements
    assert soup.find('html') is not None, "HTML root element missing"
    
    # Ensure no broken tags (basic check)
    assert '</' in str(soup), "No closing tags found"
