inherited frmMostraItensPendentes: TfrmMostraItensPendentes
  Left = 289
  Top = 334
  Width = 1024
  Height = 480
  BorderStyle = bsSizeable
  Caption = 'Itens Pendentes'
  Position = poScreenCenter
  ExplicitWidth = 1024
  ExplicitHeight = 480
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 399
    Width = 1008
    Height = 26
    TabOrder = 1
    ExplicitTop = 399
    ExplicitWidth = 1008
    ExplicitHeight = 26
    object Shape1: TShape [0]
      Left = 8
      Top = 8
      Width = 12
      Height = 12
      Brush.Color = clSkyBlue
    end
    object Label1: TLabel [1]
      Left = 24
      Top = 7
      Width = 74
      Height = 14
      Caption = 'Baixado Parcial'
      Color = clGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Shape2: TShape [2]
      Left = 112
      Top = 8
      Width = 12
      Height = 12
      Brush.Color = clMoneyGreen
    end
    object Label2: TLabel [3]
      Left = 128
      Top = 7
      Width = 64
      Height = 14
      Caption = 'Baixado Total'
      Color = clGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 927
      Height = 22
      ExplicitWidth = 927
      ExplicitHeight = 22
    end
    inherited btnSair: TBitBtnLocked
      Left = 929
      Top = 2
      Align = alRight
      ExplicitLeft = 929
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 425
    Width = 1008
    TabOrder = 2
    ExplicitTop = 425
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 837
      ExplicitLeft = 837
    end
    inherited pnlInfo: TPanel
      Width = 837
      ExplicitWidth = 837
    end
  end
  object dbgItens: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 1008
    Height = 358
    Align = alClient
    DataSource = dtsPedido
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgItensDrawColumnCell
    OnKeyDown = dbgItensKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'PCD_CODITE'
        Title.Caption = 'Item'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCD_DESITE'
        Title.Caption = 'Descri'#231#227'o'
        Width = 160
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MAR_DESMAR'
        Title.Caption = 'Marca'
        Width = 117
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_CODFAB'
        Title.Caption = 'C'#243'digo de F'#225'brica'
        Width = 120
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PCD_EMBALA'
        Title.Alignment = taRightJustify
        Title.Caption = 'Embalagem'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UNI_SIGUNI'
        Title.Caption = 'UN.'
        Width = 50
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PCD_QTDITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Qtd. Ori.'
        Width = 85
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PCD_QTDBAI'
        Title.Alignment = taRightJustify
        Title.Caption = 'Qtd. Bai.'
        Width = 85
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PCD_QTDRES'
        Title.Alignment = taRightJustify
        Title.Caption = 'Qtd. Rest.'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UNILIQ'
        Title.Alignment = taRightJustify
        Title.Caption = 'Vr. Unit'#225'r. Liq.'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOTRES'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total Restante'
        Width = 74
        Visible = True
      end>
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 358
    Width = 1008
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object lblTotal: TLabel
      Left = 807
      Top = 15
      Width = 100
      Height = 14
      Caption = 'Total Geral Restante:'
    end
    object edtTotal: TEditFocus
      Left = 909
      Top = 9
      Width = 88
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 352
    Top = 80
  end
  object dtsPedido: TDataSource
    Left = 288
    Top = 80
  end
end
