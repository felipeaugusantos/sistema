inherited frmAlteraProdCombo: TfrmAlteraProdCombo
  Width = 715
  Height = 131
  Caption = 'Altera Produtos do Combo'
  ExplicitWidth = 715
  ExplicitHeight = 131
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 58
    Width = 709
    ExplicitTop = 58
    ExplicitWidth = 709
    inherited btnSair: TBitBtnLocked
      Left = 626
      ExplicitLeft = 626
    end
  end
  inherited pnlStatus: TPanel
    Top = 86
    Width = 709
    ExplicitTop = 86
    ExplicitWidth = 709
    inherited pnlNomeForm: TPanel
      Left = 538
      ExplicitLeft = 538
    end
    inherited pnlInfo: TPanel
      Width = 538
      ExplicitWidth = 538
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 709
    Height = 60
    Align = alClient
    TabOrder = 3
    object pnlOpcoes: TPanel
      Left = 1
      Top = 28
      Width = 707
      Height = 31
      Align = alClient
      TabOrder = 1
      ExplicitTop = 29
      ExplicitHeight = 30
      object Label2: TLabel
        Left = -10
        Top = 8
        Width = 84
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Brinde:'
        Color = 16770261
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label3: TLabel
        Left = 128
        Top = 8
        Width = 63
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Tab.Pre'#231'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 250
        Top = 8
        Width = 60
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Opera'#231#227'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 360
        Top = 8
        Width = 62
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Tipo Desc:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblValDes: TLabel
        Left = 537
        Top = 8
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Valor Desc.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cmbBrinde: TComboBoxFocus
        Tag = 99
        Left = 78
        Top = 2
        Width = 47
        Height = 22
        Style = csDropDownList
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 0
        OnChange = cmbBrindeChange
        Items.Strings = (
          'SIM'
          'N'#195'O')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object cmbTabPre: TComboBoxFocus
        Tag = 99
        Left = 194
        Top = 2
        Width = 50
        Height = 22
        Style = csDropDownList
        TabOrder = 1
        Items.Strings = (
          '')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object cmbOperad: TComboBoxFocus
        Tag = 99
        Left = 313
        Top = 2
        Width = 41
        Height = 22
        Style = csDropDownList
        TabOrder = 2
        Items.Strings = (
          '+'
          '-'
          '')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object cmbTipDes: TComboBoxFocus
        Tag = 99
        Left = 426
        Top = 2
        Width = 103
        Height = 22
        Style = csDropDownList
        TabOrder = 3
        OnChange = cmbTipDesChange
        Items.Strings = (
          'PERCENTUAL'
          'VALOR FIXO')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object edtValDes: TEditFocus
        Tag = 99
        Left = 608
        Top = 2
        Width = 85
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 707
      Height = 27
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object Label1: TLabel
        Left = 25
        Top = 8
        Width = 47
        Height = 14
        Alignment = taRightJustify
        Caption = 'Produto:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblQtdIte: TLabel
        Left = 537
        Top = 7
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtCodIte: TEditFocus
        Left = 78
        Top = 2
        Width = 85
        Height = 22
        Alignment = taLeftJustify
        Color = 16770261
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesIte: TEditFocus
        Left = 164
        Top = 2
        Width = 365
        Height = 22
        Alignment = taLeftJustify
        Color = 16770261
        ReadOnly = True
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtQtdIte: TEditFocus
        Tag = 99
        Left = 608
        Top = 2
        Width = 85
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 384
    Top = 120
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 504
    Top = 128
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 584
    Top = 128
  end
end
