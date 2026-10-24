inherited frmDigOcorrencia: TfrmDigOcorrencia
  Width = 851
  Height = 218
  BorderIcons = [biSystemMenu]
  Caption = 'Digite a ocorr'#234'ncia'
  Position = poScreenCenter
  ExplicitWidth = 851
  ExplicitHeight = 218
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 173
    Width = 845
    ExplicitTop = 173
    ExplicitWidth = 845
    inherited FlwBotoes: TFlowPanel
      Width = 841
      ExplicitWidth = 841
    end
    inherited btnSair: TBitBtnLocked
      Left = 764
      ExplicitLeft = 764
    end
  end
  inherited pnlStatus: TPanel
    Top = 173
    Width = 845
    ExplicitTop = 173
    ExplicitWidth = 845
    inherited pnlNomeForm: TPanel
      Left = 674
      ExplicitLeft = 674
    end
    inherited pnlInfo: TPanel
      Width = 674
      ExplicitWidth = 674
    end
  end
  inherited pgcDados: TPageControl
    Width = 845
    Height = 173
    ExplicitWidth = 845
    ExplicitHeight = 173
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 837
      ExplicitHeight = 141
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 845
    Height = 173
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object pnlVendasPerdidas: TPanel
      Left = 2
      Top = 108
      Width = 841
      Height = 63
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object gbVendasPerdidas: TGroupBox
        Left = 0
        Top = 0
        Width = 841
        Height = 63
        Align = alClient
        Caption = '  Vendas perdidas   '
        TabOrder = 0
        object ckbIncluirOrcVendasPerdidas: TcxCheckBox
          Left = 21
          Top = 24
          Caption = 'Incluir este Or'#231'amento em Vendas Perdidas'
          TabOrder = 0
          OnKeyDown = ckbIncluirOrcVendasPerdidasKeyDown
        end
      end
    end
    object pnlGbOcorrencia: TPanel
      Left = 2
      Top = 2
      Width = 841
      Height = 106
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object gbOcorrencia: TGroupBox
        Left = 0
        Top = 0
        Width = 841
        Height = 106
        Align = alClient
        Caption = '  Ocorr'#234'ncia  '
        TabOrder = 0
        object pnlHisCom: TPanel
          Left = 2
          Top = 75
          Width = 837
          Height = 29
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          DesignSize = (
            837
            29)
          object lblHisCom: TLabel
            Left = 5
            Top = 12
            Width = 116
            Height = 14
            Alignment = taRightJustify
            Caption = 'Hist'#243'rico Complementar:'
          end
          object edtHisCom: TEditFocus
            Tag = 99
            Left = 127
            Top = 6
            Width = 698
            Height = 22
            Alignment = taLeftJustify
            Anchors = [akLeft, akTop, akRight]
            CharCase = ecUpperCase
            MaxLength = 100
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlOcorrencia: TPanel
          Left = 2
          Top = 16
          Width = 837
          Height = 59
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          DesignSize = (
            837
            59)
          object lbl2: TLabel
            Left = 64
            Top = 7
            Width = 57
            Height = 14
            Alignment = taRightJustify
            Caption = 'Ocorr'#234'ncia:'
          end
          object lblOcoCrm: TLabel
            Left = 54
            Top = 39
            Width = 67
            Height = 14
            Caption = 'Complemento:'
            Visible = False
          end
          object edtCodOco: TEditFocus
            Tag = 99
            Left = 127
            Top = 4
            Width = 50
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 3
            TabOrder = 0
            OnExit = edtCodOcoExit
            OnKeyPress = edtCodOcoKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttNumerico
          end
          object edtDesOco: TEditFocus
            Left = 178
            Top = 4
            Width = 647
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Anchors = [akLeft, akTop, akRight]
            Color = 16768952
            Enabled = False
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
          object edtCodComplementoOcorrencia: TEditFocus
            Left = 127
            Top = 33
            Width = 50
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 2
            Visible = False
            OnExit = edtCodComplementoOcorrenciaExit
            OnKeyPress = edtCodComplementoOcorrenciaKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesComplementoOcorrencia: TEditFocus
            Left = 178
            Top = 33
            Width = 647
            Height = 22
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            TabOrder = 3
            Visible = False
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 624
    Top = 65528
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 592
    Top = 65528
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 520
    Top = 16
  end
end
