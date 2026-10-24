inherited frmSelOrdItens: TfrmSelOrdItens
  Left = 357
  Top = 329
  Width = 313
  Height = 147
  BorderStyle = bsDialog
  Caption = 'Selecione a ordem dos itens no pedido'
  Position = poScreenCenter
  ExplicitWidth = 313
  ExplicitHeight = 147
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 76
    Width = 307
    Height = 26
    ExplicitTop = 76
    ExplicitWidth = 307
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 113
      Width = 115
      Height = 22
      TabOrder = 2
      ExplicitLeft = 113
      ExplicitTop = 2
      ExplicitWidth = 115
      ExplicitHeight = 22
    end
    inherited btnSair: TBitBtnLocked
      Left = 228
      Top = 2
      Align = alRight
      ModalResult = 2
      ExplicitLeft = 228
      ExplicitTop = 2
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 111
      Height = 22
      Align = alLeft
      Caption = '[ F10 ] Confirma'
      ModalResult = 1
      TabOrder = 0
    end
  end
  object rdgOrdem: TRadioGroup [2]
    Left = 0
    Top = 0
    Width = 307
    Height = 76
    Align = alClient
    ItemIndex = 1
    Items.Strings = (
      'Descri'#231#227'o do Produto'
      'Sele'#231#227'o (Ordem de marca'#231#227'o)')
    TabOrder = 2
  end
  inherited pnlStatus: TPanel
    Top = 102
    Width = 307
    ExplicitTop = 102
    ExplicitWidth = 307
    inherited pnlNomeForm: TPanel
      Left = 136
      ExplicitLeft = 136
    end
    inherited pnlInfo: TPanel
      Width = 136
      ExplicitWidth = 136
    end
  end
end
