inherited frmGeraPagamentos: TfrmGeraPagamentos
  Width = 627
  Height = 226
  Caption = 'Gera Pagamentos'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 627
  ExplicitHeight = 226
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 155
    Width = 621
    ExplicitTop = 155
    ExplicitWidth = 621
    inherited FlwBotoes: TFlowPanel
      Width = 540
      ExplicitWidth = 540
      inherited btnConfirma: TBitBtnLocked
        Align = alLeft
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 542
      Top = 2
      Align = alRight
      ExplicitLeft = 542
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 181
    Width = 621
    ExplicitTop = 181
    ExplicitWidth = 621
    inherited pnlNomeForm: TPanel
      Left = 450
      ExplicitLeft = 450
    end
    inherited pnlInfo: TPanel
      Width = 450
      ExplicitWidth = 450
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 621
    Height = 155
    Align = alClient
    ParentColor = True
    TabOrder = 3
    object Label1: TLabel
      Left = 11
      Top = 12
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 24
      Top = 36
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cnd.Pgto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label30: TLabel
      Left = 26
      Top = 60
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object Label11: TLabel
      Left = 25
      Top = 132
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Hist'#243'rico:'
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 73
      Top = 4
      Width = 63
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
      Left = 137
      Top = 4
      Width = 472
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 6
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
      Left = 73
      Top = 28
      Width = 536
      Height = 22
      CharCase = ecUpperCase
      EditMask = 
        '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
        '99.999.999.999.999.999.999.999.999;0;'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 98
      TabOrder = 1
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 73
      Top = 52
      Width = 55
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 2
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomPor: TEditFocus
      Left = 130
      Top = 52
      Width = 479
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtHistorico: TEditFocus
      Tag = 99
      Left = 73
      Top = 124
      Width = 536
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 50
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 50
      TipoTexto = ttAlfanumerico
    end
    inline fraCentroCusto: TfraCentroCustoEditFocus
      Left = -21
      Top = 76
      Width = 638
      Height = 22
      TabOrder = 3
      ExplicitLeft = -21
      ExplicitTop = 76
      ExplicitWidth = 638
      inherited lblEventos: TLabel
        Left = 35
        Top = 8
        Width = 56
        Height = 14
        Caption = 'Ctr. Custos:'
        ExplicitLeft = 35
        ExplicitTop = 8
        ExplicitWidth = 56
        ExplicitHeight = 14
      end
      inherited edtCodEve: TEditFocus
        Height = 22
        ExplicitHeight = 22
      end
      inherited edtDesEve: TEditFocus
        Left = 151
        Width = 479
        Height = 22
        ExplicitLeft = 151
        ExplicitWidth = 479
        ExplicitHeight = 22
      end
    end
    inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
      Left = 5
      Top = 99
      Width = 609
      Height = 24
      TabOrder = 4
      ExplicitLeft = 5
      ExplicitTop = 99
      ExplicitWidth = 609
      ExplicitHeight = 24
      inherited lblPlaContas: TLabel
        Left = 0
        Top = 5
        Width = 66
        Height = 14
        Caption = 'Plano Contas:'
        ExplicitLeft = 0
        ExplicitTop = 5
        ExplicitWidth = 66
        ExplicitHeight = 14
      end
      inherited edtDesCta: TEditFocus
        Left = 125
        Top = 1
        Width = 479
        Height = 22
        ExplicitLeft = 125
        ExplicitTop = 1
        ExplicitWidth = 479
        ExplicitHeight = 22
      end
      inherited MskCodCta: TMaskEdit
        Left = 68
        Top = 1
        Width = 55
        Height = 22
        OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
        ExplicitLeft = 68
        ExplicitTop = 1
        ExplicitWidth = 55
        ExplicitHeight = 22
      end
    end
  end
end
