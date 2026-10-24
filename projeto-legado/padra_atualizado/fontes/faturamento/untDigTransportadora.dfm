inherited frmDigTransportadora: TfrmDigTransportadora
  Width = 516
  Height = 282
  Caption = 'Escolha a Transportadora e o Frete'
  OnDestroy = FormDestroy
  ExplicitWidth = 516
  ExplicitHeight = 282
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 211
    Width = 510
    ExplicitTop = 190
    ExplicitWidth = 510
    inherited FlwBotoes: TFlowPanel
      Width = 506
      ExplicitWidth = 506
    end
    inherited btnSair: TBitBtnLocked
      Left = 430
      ExplicitLeft = 430
    end
  end
  inherited pnlStatus: TPanel
    Top = 237
    Width = 510
    ExplicitTop = 216
    ExplicitWidth = 510
    inherited pnlNomeForm: TPanel
      Left = 339
      ExplicitLeft = 339
    end
    inherited pnlInfo: TPanel
      Width = 339
      ExplicitWidth = 339
    end
  end
  object pnlPrincipal: TPanel [2]
    Left = 0
    Top = 0
    Width = 510
    Height = 211
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitHeight = 190
    inline fraTransportadora: TfraDadosFechamentoPedidoTransportadoraFrame
      Left = 0
      Top = 0
      Width = 510
      Height = 206
      VertScrollBar.Range = 45
      Align = alTop
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      ExplicitWidth = 510
      ExplicitHeight = 206
      inherited pnlFundo: TPanel
        Width = 510
        Height = 206
        ExplicitWidth = 510
        ExplicitHeight = 186
        inherited pnlTransportadora: TGroupBox
          Width = 506
          Height = 204
          Font.Pitch = fpVariable
          ExplicitWidth = 506
          ExplicitHeight = 184
          inherited pnlTransportadoraFrete: TPanel
            Width = 502
            ExplicitWidth = 502
            inherited lblValFre: TLabel
              Font.Pitch = fpVariable
            end
            inherited Label4: TLabel
              Font.Pitch = fpVariable
            end
            inherited Label23: TLabel
              Font.Pitch = fpVariable
            end
            inherited lblQtdTra: TLabel
              Font.Pitch = fpVariable
            end
            inherited lblEspVol: TLabel
              Font.Pitch = fpVariable
            end
            inherited btnCalcVolume: TSpeedButton
              Font.Pitch = fpVariable
            end
            inherited btnCalcFreSug: TSpeedButton
              Left = 205
              Font.Pitch = fpVariable
              ExplicitLeft = 205
            end
            inherited Label7: TLabel
              Font.Pitch = fpVariable
            end
            inherited Label2: TLabel
              Font.Pitch = fpVariable
            end
            inherited lblValFreCot: TLabel
              Font.Pitch = fpVariable
            end
            inherited edtValFre: TEditFocus
              Width = 93
              Font.Pitch = fpVariable
              MaxLength = 10
              OnChange = fraTransportadoraedtValFreChange
              OnEnter = fraTransportadoraedtValFreEnter
              OnExit = fraTransportadoraedtValFreExit
              TamCampo = 10
              ExplicitWidth = 93
            end
            inherited edtDesAce: TEditFocus
              Font.Pitch = fpVariable
            end
            inherited edtQtdTra: TEditFocus
              Font.Pitch = fpVariable
            end
            inherited edtEspVol: TEditFocus
              Font.Pitch = fpVariable
            end
            inherited cmbTipFre: TComboBoxFocus
              Font.Pitch = fpVariable
            end
            inherited edtNumReg: TEditFocus
              Font.Pitch = fpVariable
            end
            inherited btnCalcularFrete: TBitBtnLocked
              Left = 233
              Font.Pitch = fpVariable
              ExplicitLeft = 233
            end
            inherited edtCodTra: TEditFocus
              Font.Pitch = fpVariable
            end
            inherited edtNomTra: TEditFocus
              Font.Pitch = fpVariable
            end
            inherited edtValFreCot: TEditFocus
              Font.Pitch = fpVariable
            end
          end
          inherited pnlTraRedesp: TPanel
            Top = 130
            Width = 502
            Font.Pitch = fpVariable
            ExplicitTop = 110
            ExplicitWidth = 502
          end
          inherited pnlPeso: TPanel
            Top = 176
            Width = 502
            Font.Pitch = fpVariable
            ExplicitTop = 156
            ExplicitWidth = 502
          end
          inherited pnlRota: TPanel
            Top = 153
            Width = 502
            ExplicitTop = 133
            ExplicitWidth = 502
            inherited lblRota: TLabel
              Font.Pitch = fpVariable
            end
          end
        end
      end
      inherited tmrHideHints: TTimer
        Left = 216
        Top = 80
      end
      inherited HintControler: TcxHintStyleController
        Left = 248
        Top = 80
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 184
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 152
    Top = 80
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 120
    Top = 80
  end
end
