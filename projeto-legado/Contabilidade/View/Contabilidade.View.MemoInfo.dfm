inherited frmMemoInfo: TfrmMemoInfo
  Width = 920
  Height = 427
  Caption = ''
  ExplicitWidth = 920
  ExplicitHeight = 427
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 356
    Width = 914
    TabOrder = 1
    ExplicitTop = 356
    ExplicitWidth = 914
    inherited FlwBotoes: TFlowPanel
      Width = 910
      ExplicitWidth = 910
      inherited btnConfirma: TBitBtnLocked
        Caption = '&OK'
      end
      object btnExportar: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 100
        Height = 22
        Caption = 'Exportar PDF'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
          333333333333337FF3333333333333903333333333333377FF33333333333399
          03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
          99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
          99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
          03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
          33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
          33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
          3333777777333333333333333333333333333333333333333333}
        NumGlyphs = 2
        TabOrder = 1
        Visible = False
        OnClick = btnExportarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 834
      ExplicitLeft = 834
    end
  end
  inherited pnlStatus: TPanel
    Top = 382
    Width = 914
    TabOrder = 2
    ExplicitTop = 382
    ExplicitWidth = 914
    inherited pnlNomeForm: TPanel
      Left = 743
      ExplicitLeft = 743
    end
    inherited pnlInfo: TPanel
      Width = 743
      ExplicitWidth = 743
    end
  end
  object edtInfo: TcxMemo [2]
    Left = 0
    Top = 0
    Align = alClient
    ParentFont = False
    Properties.ReadOnly = True
    Properties.ScrollBars = ssBoth
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = -15
    Style.Font.Name = 'Courier New'
    Style.Font.Pitch = fpVariable
    Style.Font.Style = []
    Style.IsFontAssigned = True
    TabOrder = 0
    Height = 356
    Width = 914
  end
  object frxReport: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 46266.485700150460000000
    ReportOptions.LastChange = 46266.506213634260000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 464
    Top = 64
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object PageHeader1: TfrxPageHeader        
        Height = 967.559680000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object memTexto: TfrxMemoView
          Left = 2.338590000000000000
          Top = 2.559060000000000000
          Width = 706.772110000000000000
          Height = 907.087200000000000000
        end
      end
    end
  end
  object frxExpPDF: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False   
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 528
    Top = 224
  end
end
