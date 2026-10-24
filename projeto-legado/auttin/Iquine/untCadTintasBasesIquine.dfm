inherited frmCadTintasBasesIquine: TfrmCadTintasBasesIquine
  Height = 230
  Caption = 'Cadastro de Bases - Iquine'
  ExplicitHeight = 230
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 158
    ExplicitTop = 158
  end
  inherited pgcDados: TPageControl
    Height = 158
    ExplicitHeight = 158
    inherited tbsGeral: TTabSheet
      ExplicitHeight = 126
    end
  end
  inherited pnlCampos: TPanel
    Height = 158
    ExplicitHeight = 158
    object lblProduto: TLabel [9]
      Left = 28
      Top = 131
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    inherited dbeEmbala: TDBEditFocus
      TabOrder = 12
    end
    object dbeProduto: TDBComboBoxFocus
      Tag = 99
      Left = 72
      Top = 127
      Width = 253
      Height = 22
      Style = csOwnerDrawFixed
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 186
    ExplicitTop = 186
  end
end
