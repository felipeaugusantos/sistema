inherited frmCfgPisCofinsSuframa: TfrmCfgPisCofinsSuframa
  Width = 400
  Height = 163
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Al'#237'quota Pis/Cofins - Zona Franca(Exce'#231#227'o)'
  Position = poMainFormCenter
  ExplicitWidth = 400
  ExplicitHeight = 163
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 90
    Width = 394
    TabOrder = 2
    ExplicitTop = 90
    ExplicitWidth = 394
    inherited FlwBotoes: TFlowPanel
      Width = 390
      ExplicitWidth = 390
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 77
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '&Confirma'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000040000
          00130000001E0000002000000020000000200000002100000021000000210000
          002200000022000000220000002300000021000000160000000500000012281E
          16CB37291EFF463A31FFBD8150FFBC7E4DFFB97949FFB67646FFB37141FFB06D
          3DFFAD6839FFAB6535FF42362EFF3D3026FF241A13CE00000015000000193B2C
          21FF685C54FF483C34FFE8C28BFFE7C088FFE6BD85FFE5BB81FFE4B87CFFE3B5
          79FFE2B276FFE2B273FF443931FF51433AFF34261DFF0000001E000000183E2F
          24FF6C6057FF4A3F37FFD9B27DFFD8B07BFFD7AE77FFD7AB74FFD6A970FFD5A6
          6DFFD4A56AFFD4A268FF473B33FF5B4F47FF37291EFF0000001D000000164031
          26FF6F645CFF4C4038FFFFFFFFFFF7F1EBFFF7F0EBFFF7F0EBFFF7EFEBFFF6EF
          EAFFF6EFEAFFF6EFE9FF463B34FF5D5249FF3A2C21FF0000001B000000144434
          29FF73675FFF4F443CFFFFFFFFFFF8F2EDFFF8F1EDFFF7F1EDFFF7F0EDFFF8F1
          EBFFF7F0EBFFF7F0ECFF4A4037FF5F534BFF3D2E23FF00000019000000124637
          2CFF776B63FF50453DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF4E433BFF61544CFF403126FF0000001700000010493A
          2FFF796E66FF50453DFF61564EFF60564EFF60554DFF5F544CFF5E544CFF5E53
          4BFF5D524AFF5C5249FF5B5149FF61554DFF433429FF000000150000000E4C3D
          32FF7C706AFF674E44FF654B42FF634A41FF61473FFF5F473EFF5C443CFF5B43
          3AFF594139FF584038FF573F37FF63574FFF46362DFF000000130000000D4E3F
          35FF80746DFF6B5248FFF4ECE6FFE9DACEFFE9D8CDFFE9D8CCFFE9D8CBFFE8D7
          CAFFF3EAE2FFF3E9E2FF5A4139FF645850FF483A2FFF000000110000000B5142
          36FF827770FF70564DFFF9F5F2FFF4EAE4FFF1E6DEFFEBDCD2FFE9D9CCFF4E41
          3DFF60534CFFF3EAE3FF5D453CFF655951FF4C3D32FF0000000F000000095344
          39FF857A73FF755A50FFFAF6F3FFF5EDE7FFF4EDE6FFF4ECE6FFEFE2DAFF493D
          38FF5A4D46FFF4EBE4FF60483FFF655A52FF4F3F34FF0000000D000000075545
          3AFF887D76FF795E54FFFAF6F4FFF5EEE9FFF5EDE7FFF4EDE7FFF4ECE6FF473A
          36FF483D36FFE9D9CDFF644C43FF675A52FF514137FF0000000B000000065748
          3DFF898079FF7C6157FFFAF7F4FFFAF6F4FFFAF6F4FFFAF6F3FFFAF6F3FFFAF5
          F2FFF5EEE9FFF4ECE6FF695046FF82776FFF534439FF00000009000000034235
          2EC058493DFF7F645AFF998178FF967F75FF937A72FF8E786DFF8B7269FF866E
          64FF82695FFF7D645BFF6E544AFF56453BFF3F332BC200000005000000000000
          0002000000030000000400000004000000040000000400000005000000050000
          0005000000050000000500000006000000060000000400000001}
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 314
      ExplicitLeft = 314
    end
  end
  inherited pnlStatus: TPanel
    Top = 118
    Width = 394
    TabOrder = 3
    ExplicitTop = 118
    ExplicitWidth = 394
    inherited pnlNomeForm: TPanel
      Left = 223
      ExplicitLeft = 223
    end
    inherited pnlInfo: TPanel
      Width = 223
      ExplicitWidth = 223
    end
  end
  object GroupBox1: TGroupBox [2]
    Tag = 99
    Left = 0
    Top = 0
    Width = 197
    Height = 90
    Align = alLeft
    Caption = ' PIS '
    TabOrder = 0
    object Label1: TLabel
      Left = 35
      Top = 17
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'CST:'
    end
    object Label2: TLabel
      Left = 16
      Top = 41
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = '% Base:'
    end
    object Label3: TLabel
      Left = 15
      Top = 65
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Al'#237'quota:'
    end
    object edtPISCST: TEditFocus
      Tag = 99
      Left = 63
      Top = 14
      Width = 29
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 2
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPisBase: TEditFocus
      Tag = 99
      Left = 63
      Top = 38
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPisAliquota: TEditFocus
      Tag = 99
      Left = 63
      Top = 62
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object GroupBox2: TGroupBox [3]
    Tag = 99
    Left = 197
    Top = 0
    Width = 197
    Height = 90
    Align = alLeft
    Caption = ' COFINS '
    TabOrder = 1
    object Label4: TLabel
      Left = 43
      Top = 17
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'CST:'
    end
    object Label5: TLabel
      Left = 24
      Top = 41
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = '% Base:'
    end
    object Label6: TLabel
      Left = 23
      Top = 64
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Al'#237'quota:'
    end
    object edtCOFCST: TEditFocus
      Tag = 99
      Left = 71
      Top = 14
      Width = 29
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 2
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCofBase: TEditFocus
      Tag = 99
      Left = 71
      Top = 38
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCofAliquota: TEditFocus
      Tag = 99
      Left = 71
      Top = 62
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 2
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
