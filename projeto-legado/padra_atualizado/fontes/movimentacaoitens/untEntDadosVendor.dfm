inherited frmEntDadosVendor: TfrmEntDadosVendor
  Width = 521
  Height = 196
  Caption = 'Dados do Vendor'
  ExplicitWidth = 521
  ExplicitHeight = 196
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 125
    Width = 515
    TabOrder = 2
    ExplicitTop = 125
    ExplicitWidth = 515
    inherited FlwBotoes: TFlowPanel
      Width = 511
      ExplicitWidth = 511
    end
    inherited btnSair: TBitBtnLocked
      Left = 432
      ExplicitLeft = 432
    end
  end
  inherited pnlStatus: TPanel
    Top = 151
    Width = 515
    TabOrder = 3
    ExplicitTop = 151
    ExplicitWidth = 515
    inherited pnlNomeForm: TPanel
      Left = 344
      ExplicitLeft = 344
    end
    inherited pnlInfo: TPanel
      Width = 344
      ExplicitWidth = 344
    end
  end
  object pnlVendor: TPanel [2]
    Left = 0
    Top = 37
    Width = 515
    Height = 84
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object lblCliFor: TLabel
      Left = 74
      Top = 4
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object Label7: TLabel
      Left = 10
      Top = 50
      Width = 122
      Height = 14
      Alignment = taRightJustify
      Caption = 'Condi'#231#227'o de  Pagamento:'
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 137
      Top = 0
      Width = 62
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 0
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomFor: TEditFocus
      Left = 200
      Top = 0
      Width = 306
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskCndPag: TMaskEditFocus
      Tag = 99
      Left = 137
      Top = 46
      Width = 369
      Height = 22
      CharCase = ecUpperCase
      EditMask = 
        '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
        '99.999.999.999.999.999.999.999.999;0;'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 98
      TabOrder = 3
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
      Left = 53
      Top = 23
      Width = 459
      Height = 22
      TabOrder = 2
      ExplicitLeft = 53
      ExplicitTop = 23
      ExplicitWidth = 459
      inherited lblPlaContas: TLabel
        Width = 81
        Height = 14
        ExplicitWidth = 81
        ExplicitHeight = 14
      end
      inherited edtDesCta: TEditFocus
        Left = 147
        Width = 306
        Height = 22
        ExplicitLeft = 147
        ExplicitWidth = 306
        ExplicitHeight = 22
      end
      inherited MskCodCta: TMaskEdit
        Left = 84
        Width = 62
        Height = 22
        OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
        ExplicitLeft = 84
        ExplicitWidth = 62
        ExplicitHeight = 22
      end
    end
  end
  object pnlValVendor: TPanel [3]
    Left = 0
    Top = 0
    Width = 515
    Height = 37
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Label16: TLabel
      Left = 52
      Top = 11
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor do Vendor:'
    end
    object edtValVen: TEditFocus
      Tag = 99
      Left = 137
      Top = 7
      Width = 62
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 216
    Top = 96
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 272
    Top = 0
  end
end
