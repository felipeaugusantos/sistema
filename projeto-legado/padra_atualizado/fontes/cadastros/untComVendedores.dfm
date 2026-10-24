inherited frmComVendedores: TfrmComVendedores
  Left = 273
  Top = 189
  Width = 600
  Height = 549
  Caption = 'Comis'#227'o do vendedor por faixa de desconto'
  Position = poScreenCenter
  ExplicitWidth = 600
  ExplicitHeight = 549
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 476
    Width = 594
    ExplicitTop = 468
    ExplicitWidth = 594
    DesignSize = (
      594
      28)
    object Label2: TLabel [0]
      Left = 8
      Top = 6
      Width = 411
      Height = 14
      Caption = 
        '[INS] Insere novo registro - [DEL] Apaga registro selecionado - ' +
        '[ENTER] Altera registro'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 590
      Visible = False
      ExplicitWidth = 590
    end
    inherited btnSair: TBitBtnLocked
      Left = 511
      ExplicitLeft = 511
    end
  end
  inherited pnlStatus: TPanel
    Top = 504
    Width = 594
    ExplicitTop = 496
    ExplicitWidth = 594
    inherited pnlNomeForm: TPanel
      Left = 423
      ExplicitLeft = 423
    end
    inherited pnlInfo: TPanel
      Width = 423
      ExplicitWidth = 423
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 594
    Height = 476
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 2
    ExplicitHeight = 468
    object lblCodigo: TLabel
      Left = 16
      Top = 96
      Width = 33
      Height = 14
      Caption = 'C'#243'digo'
    end
    object lblDescri: TLabel
      Left = 80
      Top = 96
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
    end
    object lblInicial: TLabel
      Left = 320
      Top = 96
      Width = 39
      Height = 14
      Caption = '% Inicial'
    end
    object lblFinal: TLabel
      Left = 388
      Top = 96
      Width = 35
      Height = 14
      Caption = '% Final'
    end
    object lblComis: TLabel
      Left = 456
      Top = 96
      Width = 60
      Height = 14
      Caption = '% Comiss'#227'o'
    end
    object lblAviso: TLabel
      Left = 2
      Top = 144
      Width = 590
      Height = 14
      Align = alBottom
      Alignment = taCenter
      Caption = 
        'Esta faixa de margem atende somente '#224' empresa: <XXX>-<NOMEDAEMPR' +
        'ESA>'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
      ExplicitTop = -235
      ExplicitWidth = 385
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 6
      Width = 574
      Height = 81
      Caption = 'Dados do Operador'
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 27
        Width = 49
        Height = 16
        Caption = 'C'#243'digo:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCodOpe: TLabel
        Left = 72
        Top = 27
        Width = 60
        Height = 16
        Caption = 'lblCodOpe'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 24
        Top = 51
        Width = 41
        Height = 16
        Caption = 'Nome:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNomOpe: TLabel
        Left = 72
        Top = 51
        Width = 64
        Height = 16
        Caption = 'lblNomOpe'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
    end
    object dbgComVen: TDBGridCitel
      Left = 2
      Top = 158
      Width = 590
      Height = 316
      Align = alBottom
      DataSource = dtsComOpe
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 7
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnKeyDown = dbgComVenKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'COM_CODCOM'
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COM_DESCOM'
          Title.Caption = 'Descri'#231#227'o'
          Width = 241
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COM_PERINI'
          Title.Caption = '% Inicial'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COM_PERFIN'
          Title.Caption = '% Final'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COM_PERCOM'
          Title.Caption = '% Comiss'#227'o'
          Visible = True
        end>
    end
    object edtCodigo: TEditFocus
      Left = 16
      Top = 112
      Width = 57
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16773868
      ReadOnly = True
      TabOrder = 1
      Text = 'edtCodigo'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDescri: TEditFocus
      Tag = 99
      Left = 80
      Top = 112
      Width = 233
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 30
      TabOrder = 2
      Text = 'EDTDESCRI'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtInicial: TEditFocus
      Tag = 99
      Left = 320
      Top = 112
      Width = 59
      Height = 22
      Alignment = taRightJustify
      MaxLength = 10
      TabOrder = 3
      Text = 'edtInicial'
      OnExit = edtInicialExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtFinal: TEditFocus
      Tag = 99
      Left = 388
      Top = 112
      Width = 58
      Height = 22
      Alignment = taRightJustify
      MaxLength = 10
      TabOrder = 4
      Text = 'edtFinal'
      OnExit = edtFinalExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtComis: TEditFocus
      Tag = 99
      Left = 456
      Top = 112
      Width = 60
      Height = 22
      Alignment = taRightJustify
      MaxLength = 10
      TabOrder = 5
      Text = 'edtComis'
      OnExit = edtComisExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object btnIncluir: TBitBtnLocked
      Left = 524
      Top = 108
      Width = 57
      Height = 25
      Caption = '&Incluir'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333033333
        33333333373F33333333333330B03333333333337F7F33333333333330F03333
        333333337F7FF3333333333330B00333333333337F773FF33333333330F0F003
        333333337F7F773F3333333330B0B0B0333333337F7F7F7F3333333300F0F0F0
        333333377F73737F33333330B0BFBFB03333337F7F33337F33333330F0FBFBF0
        3333337F7333337F33333330BFBFBFB033333373F3333373333333330BFBFB03
        33333337FFFFF7FF3333333300000000333333377777777F333333330EEEEEE0
        33333337FFFFFF7FF3333333000000000333333777777777F33333330000000B
        03333337777777F7F33333330000000003333337777777773333}
      NumGlyphs = 2
      TabOrder = 6
      OnClick = btnIncluirClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 440
    Top = 272
  end
  object dtsComOpe: TDataSource
    Left = 424
    Top = 24
  end
end
