inherited frmFatSepFutDigSeparador: TfrmFatSepFutDigSeparador
  Left = 471
  Top = 118
  Width = 800
  Height = 600
  BorderIcons = [biSystemMenu]
  Caption = 'Entrega Futura - Digita'#231#227'o do Separador'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 527
    Width = 794
    ExplicitTop = 527
    ExplicitWidth = 794
    inherited FlwBotoes: TFlowPanel
      Width = 790
      ExplicitTop = 2
      ExplicitWidth = 790
    end
    inherited btnSair: TBitBtnLocked
      Left = 915
      ExplicitLeft = 915
    end
  end
  inherited pgcDados: TPageControl
    Width = 794
    Height = 527
    TabOrder = 1
    TabStop = False
    Visible = False
    ExplicitWidth = 794
    ExplicitHeight = 527
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 786
      ExplicitHeight = 495
    end
  end
  object dbgConsulta: TDBGridCitel [3]
    Left = 0
    Top = 0
    Width = 794
    Height = 527
    Align = alClient
    DataSource = dsGrid
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgConsultaDrawColumnCell
    OnKeyDown = dbgConsultaKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DTAIMP'
        Title.Alignment = taCenter
        Title.Caption = 'Data Sep.'
        Width = 63
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'HORIMP'
        Title.Alignment = taCenter
        Title.Caption = 'Hora Sep.'
        Width = 62
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DTAENT'
        Title.Alignment = taCenter
        Title.Caption = 'Data Venda'
        Width = 62
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'NUMDOC'
        Title.Alignment = taCenter
        Title.Caption = 'N'#186' Docum.'
        Width = 131
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ESPDOC'
        Title.Alignment = taCenter
        Title.Caption = 'Esp.'
        Width = 33
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CODEMP'
        Title.Alignment = taCenter
        Title.Caption = 'Emp.'
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMCLI'
        Title.Caption = 'Cliente'
        Width = 208
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMSEP'
        Title.Caption = 'Separador'
        Width = 143
        Visible = True
      end>
  end
  object pnl1: TPanel [4]
    Left = 0
    Top = 527
    Width = 794
    Height = 28
    Align = alBottom
    Color = clGray
    ParentBackground = False
    TabOrder = 4
    DesignSize = (
      794
      28)
    object lbl1: TLabel
      Left = 1
      Top = 1
      Width = 792
      Height = 26
      Align = alClient
      Alignment = taCenter
      Caption = 
        'Pressione [Enter] para informar ou limpar o separador / Pression' +
        'e [F5] para atualizar os documentos'
      Color = clGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 555
      ExplicitHeight = 14
    end
    object lblSemSal: TLabel
      Left = 730
      Top = 7
      Width = 59
      Height = 14
      Anchors = [akTop, akRight]
      Caption = 'Separados'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object shpSemSal: TShape
      Left = 714
      Top = 8
      Width = 12
      Height = 13
      Anchors = [akTop, akRight]
      Brush.Color = clBlue
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 794
    TabOrder = 3
    ExplicitTop = 555
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 432
    Top = 120
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 464
    Top = 120
  end
  object cdsGrid: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 464
    Top = 152
  end
  object dsGrid: TDataSource
    DataSet = cdsGrid
    Left = 432
    Top = 152
  end
end
