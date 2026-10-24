inherited frmCtpLiberacaoPrevisaoDados: TfrmCtpLiberacaoPrevisaoDados
  Width = 579
  Height = 206
  Caption = 'Atualiza'#231#227'o de dados das duplicatas previsionadas'
  ExplicitWidth = 579
  ExplicitHeight = 206
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 135
    Width = 573
    TabOrder = 1
    ExplicitTop = 135
    ExplicitWidth = 573
    inherited FlwBotoes: TFlowPanel
      Width = 569
      ExplicitWidth = 569
    end
    inherited btnSair: TBitBtnLocked
      Left = 493
      ExplicitLeft = 493
    end
  end
  inherited pnlStatus: TPanel
    Top = 161
    Width = 573
    TabOrder = 2
    ExplicitTop = 161
    ExplicitWidth = 573
    inherited pnlNomeForm: TPanel
      Left = 402
      ExplicitLeft = 402
    end
    inherited pnlInfo: TPanel
      Width = 402
      ExplicitWidth = 402
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 573
    Height = 135
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label24: TLabel
      Left = 53
      Top = 60
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object Label1: TLabel
      Left = 52
      Top = 82
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Hist'#243'rico:'
    end
    object lblMotivo: TLabel
      Left = 7
      Top = 104
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'Motivo da reprova:'
    end
    object edtDesPor: TEditFocus
      Left = 174
      Top = 57
      Width = 386
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 101
      Top = 57
      Width = 72
      Height = 22
      Alignment = taLeftJustify
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
      TipoTexto = ttAlfanumerico
    end
    inline fraCentroCusto: TfraCentroCustoEditFocus
      Left = 7
      Top = 35
      Width = 556
      Height = 22
      TabOrder = 1
      ExplicitLeft = 7
      ExplicitTop = 35
      ExplicitWidth = 556
      inherited lblEventos: TLabel
        Left = 3
        Top = 3
        Width = 87
        Height = 14
        ExplicitLeft = 3
        ExplicitTop = 3
        ExplicitWidth = 87
        ExplicitHeight = 14
      end
      inherited edtCodEve: TEditFocus
        Width = 72
        Height = 22
        ExplicitWidth = 72
        ExplicitHeight = 22
      end
      inherited edtDesEve: TEditFocus
        Left = 167
        Width = 386
        Height = 22
        Enabled = True
        ExplicitLeft = 167
        ExplicitWidth = 386
        ExplicitHeight = 22
      end
    end
    object edtHistorico: TEditFocus
      Left = 101
      Top = 79
      Width = 459
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Ctl3D = True
      MaxLength = 100
      ParentCtl3D = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtMotivo: TEditFocus
      Tag = 99
      Left = 101
      Top = 101
      Width = 459
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Ctl3D = True
      MaxLength = 100
      ParentCtl3D = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    inline fraPlanoDeContasCtp: TfraPlanoDeContasMskEdit
      Left = 14
      Top = 13
      Width = 548
      Height = 22
      TabOrder = 0
      ExplicitLeft = 14
      ExplicitTop = 13
      ExplicitWidth = 548
      inherited lblPlaContas: TLabel
        Left = 2
        Width = 81
        Height = 14
        ExplicitLeft = 2
        ExplicitWidth = 81
        ExplicitHeight = 14
      end
      inherited edtDesCta: TEditFocus
        Left = 160
        Width = 386
        Height = 22
        ExplicitLeft = 160
        ExplicitWidth = 386
        ExplicitHeight = 22
      end
      inherited MskCodCta: TMaskEdit
        Left = 87
        Width = 72
        Height = 22
        OnKeyPress = fraPlanoDeContasCtpMskCodCtaKeyPress
        ExplicitLeft = 87
        ExplicitWidth = 72
        ExplicitHeight = 22
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 296
    Top = 224
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 512
    Top = 232
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 408
    Top = 224
  end
end
