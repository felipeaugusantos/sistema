inherited frmAbstractDigTintaIndustrial: TfrmAbstractDigTintaIndustrial
  Height = 377
  ExplicitHeight = 377
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 304
    ExplicitTop = 304
  end
  inherited pnlStatus: TPanel
    Top = 332
    ExplicitTop = 332
  end
  inherited pnlGeral: TPanel
    Height = 304
    ExplicitHeight = 304
    inherited Label5: TLabel
      Top = 261
      ExplicitTop = 261
    end
    object lblVolumeFinal: TLabel [5]
      Left = 236
      Top = 235
      Width = 88
      Height = 14
      Caption = 'Volume Final (ML):'
    end
    inherited edtDesAdi: TEditFocus
      Top = 276
      ExplicitTop = 276
    end
    object rdgEmbalagens: TRadioGroup
      Left = 8
      Top = 96
      Width = 419
      Height = 134
      Caption = 'Embalagens'
      TabOrder = 7
      OnClick = rdgEmbalagensClick
    end
    object chkUsaCatalisador: TCheckBox
      Left = 8
      Top = 235
      Width = 97
      Height = 17
      Caption = 'Usar Catalisador'
      TabOrder = 8
      OnClick = chkUsaCatalisadorClick
    end
  end
  inherited pnlTotais: TPanel
    Height = 304
    ExplicitHeight = 304
  end
  object edtVolumeFinal: TEditFocus [4]
    Tag = 99
    Left = 327
    Top = 232
    Width = 100
    Height = 22
    Alignment = taRightJustify
    ReadOnly = True
    TabOrder = 4
    Text = '0,900'
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
  end
end
