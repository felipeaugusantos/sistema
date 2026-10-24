inherited frmTransfCodCorIndustrial: TfrmTransfCodCorIndustrial
  Height = 573
  Caption = 'Transfer'#234'ncia de C'#243'digo de Cores'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitHeight = 573
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 500
    TabOrder = 1
    ExplicitTop = 501
    inherited btnSair: TBitBtnLocked
      Left = 404
      Top = 2
      Height = 24
      Align = alRight
      TabOrder = 1
      ExplicitLeft = 404
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 77
      Height = 24
      Align = alLeft
      Caption = '&Confirma'
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
      TabOrder = 0
      OnClick = btnConfirmaDadosClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 528
    TabOrder = 2
    ExplicitTop = 529
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 483
    Height = 94
    Align = alTop
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 83
      Height = 14
      Caption = 'Transferir da Cor'
    end
    object Label2: TLabel
      Left = 8
      Top = 48
      Width = 54
      Height = 14
      Caption = 'para a Cor:'
    end
    object edtCorOri: TEditFocus
      Tag = 99
      Left = 7
      Top = 23
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 4
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      OnKeyPress = edtCorOriKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 4
      TipoTexto = ttNumerico
    end
    object edtDesCorOri: TEditFocus
      Left = 74
      Top = 23
      Width = 247
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCorDes: TEditFocus
      Tag = 99
      Left = 7
      Top = 63
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 4
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 2
      OnKeyPress = edtCorDesKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 4
      TipoTexto = ttNumerico
    end
    object edtDesCorDes: TEditFocus
      Left = 77
      Top = 63
      Width = 247
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object lsvArqAlterados: TListView [4]
    Left = 0
    Top = 94
    Width = 483
    Height = 406
    Align = alClient
    Columns = <
      item
        Caption = 'Arquivo'
        Width = 300
      end
      item
        Alignment = taRightJustify
        Caption = 'Registro Alterados'
        Width = 150
      end>
    ColumnClick = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 4
    TabStop = False
    ViewStyle = vsReport
    ExplicitHeight = 407
  end
end
