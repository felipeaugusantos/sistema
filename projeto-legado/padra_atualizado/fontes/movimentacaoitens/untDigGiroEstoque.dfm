inherited frmDigGiroEstoque: TfrmDigGiroEstoque
  Left = 356
  Top = 184
  Width = 398
  Height = 406
  VertScrollBar.Range = 45
  ActiveControl = nil
  BorderIcons = [biSystemMenu]
  Caption = 'Calculo de giro de estoque'
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 328
    Width = 390
    TabOrder = 3
    inherited btnSair: TBitBtn
      Left = 311
    end
  end
  inherited pnlStatus: TPanel
    Top = 356
    Width = 390
    TabOrder = 2
    inherited pnlNomeForm: TPanel
      Left = 208
      Width = 182
    end
    inherited pnlInfo: TPanel
      Width = 208
    end
  end
  inherited pgcDados: TPageControl
    Width = 390
    Height = 328
    TabOrder = 1
    Visible = False
  end
  object pnlConfirma: TPanel [3]
    Left = 0
    Top = 328
    Width = 390
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    TabOrder = 4
    object btnConfirmaDados: TBitBtn
      Left = 4
      Top = 3
      Width = 77
      Height = 22
      Caption = '&Confirma'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnConfirmaDadosClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
        7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF313131726E726A66697D797A2929293838384242422828286868683131
        31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
        6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
        CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
        203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
        A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
        E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
        D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
        ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
        FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
        2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
        5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
        DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
        D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
        C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
    end
    object btnCancelaDados: TBitBtn
      Left = 309
      Top = 3
      Width = 77
      Height = 22
      Caption = 'C&ancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnCancelaClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    end
  end
  object pnlFundo: TPanel [4]
    Left = 0
    Top = 0
    Width = 390
    Height = 328
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 9
      Top = 16
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha / Grupo:'
    end
    object Label2: TLabel
      Left = 18
      Top = 39
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object Label3: TLabel
      Left = 44
      Top = 62
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object Label4: TLabel
      Left = 13
      Top = 84
      Width = 64
      Height = 14
      Alignment = taRightJustify
      Caption = 'Dias Compra:'
    end
    object mskLinGru: TMaskEditFocus
      Tag = 99
      Left = 80
      Top = 9
      Width = 57
      Height = 22
      EditMask = '99.99;0;_'
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = mskLinGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 80
      Top = 32
      Width = 57
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 8
      TabOrder = 1
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
      Alignment = taLeftJustify
    end
    object edtCodMar: TEditFocus
      Tag = 99
      Left = 80
      Top = 55
      Width = 57
      Height = 22
      MaxLength = 3
      TabOrder = 2
      OnKeyPress = edtCodMarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
      Alignment = taLeftJustify
    end
    object edtDiaCom: TEditFocus
      Tag = 99
      Left = 80
      Top = 77
      Width = 57
      Height = 22
      MaxLength = 4
      TabOrder = 3
      Text = '30'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      Alignment = taLeftJustify
    end
    object edtDesGru: TEditFocus
      Left = 137
      Top = 9
      Width = 239
      Height = 22
      TabStop = False
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtNomFor: TEditFocus
      Left = 137
      Top = 32
      Width = 239
      Height = 22
      TabStop = False
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtDesMar: TEditFocus
      Left = 137
      Top = 55
      Width = 239
      Height = 22
      TabStop = False
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object GroupBox4: TGroupBox
      Left = 80
      Top = 101
      Width = 185
      Height = 41
      Caption = 'Itens:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      object ColorLabel4: TColorLabel
        Left = 28
        Top = 17
        Width = 148
        Height = 14
        Caption = '(C)om Giro (S)em Giro (T)odos'
        CorDestaque = clRed
      end
      object edtFilGir: TEditFocus
        Tag = 99
        Left = 7
        Top = 14
        Width = 18
        Height = 22
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 0
        Text = 'C'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
        Alignment = taLeftJustify
      end
    end
    object chkExibItens: TCheckBox
      Left = 80
      Top = 147
      Width = 297
      Height = 17
      Caption = 'Exibir itens sem necessidade de compra'
      Checked = True
      State = cbChecked
      TabOrder = 8
    end
    object chkArredQtdeSugest: TCheckBox
      Left = 80
      Top = 164
      Width = 217
      Height = 17
      Caption = 'Arredondar a quantidade de sugest'#227'o'
      TabOrder = 9
    end
    object chkMultCompra: TCheckBox
      Left = 80
      Top = 181
      Width = 225
      Height = 17
      Caption = 'Considerar m'#250'ltiplo de compra'
      TabOrder = 10
    end
    object rdgOpcGir: TRadioGroup
      Left = 80
      Top = 233
      Width = 249
      Height = 46
      Caption = 'Op'#231#227'o de Giro:'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        '3 meses'
        '6 meses'
        '12 meses')
      TabOrder = 13
      OnClick = rdgOpcGirClick
    end
    object chkTdsLojas: TCheckBox
      Left = 80
      Top = 198
      Width = 225
      Height = 17
      Caption = 'Considerar todas as lojas somadas'
      TabOrder = 11
    end
    object rdgOrdem: TRadioGroup
      Left = 80
      Top = 281
      Width = 249
      Height = 46
      Caption = 'Ordem:'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Descri'#231#227'o'
        'Marca+Descri'#231#227'o')
      TabOrder = 14
      OnClick = rdgOrdemClick
    end
    object chkEstMin: TCheckBox
      Left = 80
      Top = 215
      Width = 225
      Height = 17
      Caption = 'Considerar estoque m'#237'nimo para sugest'#227'o'
      TabOrder = 12
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 408
    Top = 8
  end
end
