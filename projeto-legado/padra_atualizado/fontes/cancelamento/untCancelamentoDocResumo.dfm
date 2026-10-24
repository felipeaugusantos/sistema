inherited frmCancelamentoDocResumo: TfrmCancelamentoDocResumo
  Left = 297
  Top = 164
  Width = 800
  Height = 348
  BorderIcons = [biSystemMenu]
  Caption = 'Resumo do Cancelamento de Documentos'
  Position = poScreenCenter
  ExplicitWidth = 800
  ExplicitHeight = 348
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 275
    Width = 794
    Height = 29
    Enabled = True
    Visible = True
    ExplicitTop = 275
    ExplicitWidth = 644
    ExplicitHeight = 29
    inherited btnSair: TBitBtnLocked
      Left = 711
      Top = 3
      ExplicitLeft = 561
      ExplicitTop = 3
    end
  end
  inherited pgcDados: TPageControl
    Width = 794
    Height = 275
    ExplicitWidth = 644
    ExplicitHeight = 275
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 636
      ExplicitHeight = 243
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 794
    Height = 275
    Align = alClient
    Color = 16770261
    TabOrder = 3
    ExplicitWidth = 644
    object memResumo: TMemo
      Left = 1
      Top = 1
      Width = 792
      Height = 273
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      OnKeyDown = memResumoKeyDown
      ExplicitWidth = 642
    end
  end
  inherited pnlStatus: TPanel
    Top = 304
    Width = 794
    ExplicitTop = 304
    ExplicitWidth = 644
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 473
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 473
    end
  end
end
