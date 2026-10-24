inherited frmDigExpressao: TfrmDigExpressao
  Width = 655
  Height = 351
  ActiveControl = mmoExpressao
  BorderStyle = bsDialog
  Caption = 'Express'#227'o'
  Position = poScreenCenter
  OnClose = FormClose
  ExplicitWidth = 655
  ExplicitHeight = 351
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 279
    Width = 649
    ExplicitTop = 279
    ExplicitWidth = 649
    DesignSize = (
      649
      28)
    inherited btnSair: TBitBtnLocked
      Left = 566
      TabOrder = 1
      ExplicitLeft = 566
    end
    object btnGravar: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 75
      Height = 22
      Caption = '&Confirma'
      ModalResult = 1
      TabOrder = 0
    end
  end
  inherited pnlStatus: TPanel
    Top = 307
    Width = 649
    ExplicitTop = 307
    ExplicitWidth = 649
    inherited pnlNomeForm: TPanel
      Left = 478
      ExplicitLeft = 478
    end
    inherited pnlInfo: TPanel
      Width = 478
      ExplicitWidth = 478
    end
  end
  object mmoExpressao: TMemo [2]
    Left = 0
    Top = 0
    Width = 649
    Height = 279
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 2
  end
end
