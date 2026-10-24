inherited frmConsultaCxGridLote: TfrmConsultaCxGridLote
  Caption = 'frmConsultaCxGridLote'
  ClientHeight = 383
  ClientWidth = 785
  ExplicitWidth = 801
  ExplicitHeight = 421
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Top = 354
    Width = 785
    ExplicitTop = 354
    ExplicitWidth = 785
    inherited btnSair: TBitBtnLocked
      Left = 705
      ExplicitLeft = 705
    end
  end
  inherited prbProgresso: TProgressBar
    Top = 322
    Width = 785
    ExplicitTop = 322
    ExplicitWidth = 785
  end
  inherited pnlConsulta: TPanel
    Width = 785
    Height = 322
    ExplicitWidth = 785
    ExplicitHeight = 322
    inherited pgcRodape: TPageControl
      Top = 235
      Width = 785
      ExplicitTop = 235
      ExplicitWidth = 785
    end
    inherited cxConsulta: TcxGrid
      Width = 785
      Height = 235
      ExplicitWidth = 785
      ExplicitHeight = 235
    end
  end
  inherited pnlLegenda: TPanel
    Top = 338
    Width = 785
    ExplicitTop = 338
    ExplicitWidth = 785
  end
  inherited cxsrConsulta: TcxStyleRepository
    PixelsPerInch = 96
  end
end
