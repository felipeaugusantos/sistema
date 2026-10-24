inherited frmGarantiaBaixaEnvioConsertoMotivo: TfrmGarantiaBaixaEnvioConsertoMotivo
  Caption = 'Garantia - baixa envio para conserto'
  ClientHeight = 218
  ClientWidth = 641
  ExplicitWidth = 657
  ExplicitHeight = 257
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlPrincipal: TPanel
    Width = 641
    Height = 218
    ExplicitWidth = 641
    ExplicitHeight = 218
    inherited pnlMensagem: TPanel
      Width = 639
      Height = 147
      TabOrder = 1
      TabStop = True
      ExplicitWidth = 639
      ExplicitHeight = 147
      inherited lblMensagem: TLabel
        Align = alNone
        Visible = False
      end
      object rbAbatimentoBoleto: TRadioButton
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 631
        Height = 17
        Align = alTop
        Caption = 'Abatimento em boleto'
        TabOrder = 0
      end
      object rbCreditoConta: TRadioButton
        AlignWithMargins = True
        Left = 4
        Top = 27
        Width = 631
        Height = 17
        Align = alTop
        Caption = 'Cr'#233'dito em conta'
        TabOrder = 1
      end
      object rbNotaBonificacao: TRadioButton
        AlignWithMargins = True
        Left = 4
        Top = 50
        Width = 631
        Height = 17
        Align = alTop
        Caption = 'Nota de bonifica'#231#227'o'
        TabOrder = 2
      end
      object rbProdutoSaiuLinha: TRadioButton
        AlignWithMargins = True
        Left = 4
        Top = 73
        Width = 631
        Height = 17
        Align = alTop
        Caption = 'Produto saiu de linha'
        TabOrder = 3
      end
      object rbOutros: TRadioButton
        AlignWithMargins = True
        Left = 4
        Top = 96
        Width = 631
        Height = 17
        Align = alTop
        Caption = 'Outros'
        TabOrder = 4
      end
      object edtOutros: TEdit
        AlignWithMargins = True
        Left = 4
        Top = 119
        Width = 631
        Height = 21
        Align = alTop
        Enabled = False
        TabOrder = 5
        OnKeyDown = edtOutrosKeyDown
      end
    end
    inherited pblTitulo: TPanel
      Width = 639
      TabOrder = 0
      ExplicitWidth = 639
      inherited lblTitulo: TLabel
        Width = 637
        Height = 28
        Caption = 'Motivo'
        ExplicitWidth = 637
      end
    end
    inherited pnlBotoes: TPanel
      Top = 178
      Width = 639
      ParentFont = True
      OnEnter = pnlBotoesEnter
      ExplicitTop = 178
      ExplicitWidth = 639
      object btnConfirmar: TBitBtnLocked
        Left = 429
        Top = 6
        Width = 98
        Height = 25
        Caption = '[F10] Confirmar'
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
      object btnSair: TBitBtnLocked
        Left = 532
        Top = 6
        Width = 98
        Height = 25
        Caption = '[ESC] Sair'
        TabOrder = 1
        OnClick = btnSairClick
      end
    end
  end
  inherited popAreaTransf: TPopupMenu
    Left = 200
    Top = 65520
  end
end
