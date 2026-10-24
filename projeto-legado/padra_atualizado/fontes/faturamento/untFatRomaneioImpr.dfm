inherited frmFatRomaneioImpr: TfrmFatRomaneioImpr
  Left = 411
  Top = 101
  Width = 330
  Height = 614
  BorderIcons = [biSystemMenu]
  Caption = 'Impress'#227'o - Romaneio'
  Position = poMainFormCenter
  ExplicitTop = -151
  ExplicitWidth = 330
  ExplicitHeight = 614
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 542
    Width = 324
    TabOrder = 2
    ExplicitTop = 542
    ExplicitWidth = 324
    inherited btnSair: TBitBtnLocked
      Left = 235
      TabOrder = 1
      Visible = False
      ExplicitLeft = 235
    end
    object btnConfirmar: TBitBtnLocked
      Left = 9
      Top = 3
      Width = 77
      Height = 22
      Caption = '&Confirmar'
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
      OnClick = btnConfirmarClick
    end
  end
  object grbRota: TGroupBox [2]
    Left = 10
    Top = 5
    Width = 304
    Height = 350
    Caption = 'Rota do Romaneio - Resumos:'
    TabOrder = 0
    object ckbImprimir: TCheckBox
      Tag = 99
      Left = 7
      Top = 20
      Width = 266
      Height = 17
      Caption = 'Imprimir Romaneio'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = ckbImprimirClick
    end
    object pnlDadRom: TPanel
      Left = 2
      Top = 39
      Width = 300
      Height = 309
      Align = alBottom
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object clbQtdVol: TColorLabel
        Left = 42
        Top = 24
        Width = 164
        Height = 14
        Caption = 'Imprimir (Q)uantidade ou (V)olume'
        CorDestaque = clRed
      end
      object clbDesLoc: TColorLabel
        Left = 42
        Top = 48
        Width = 232
        Height = 14
        Caption = 'Ordenar por (D)escri'#231#227'o ou (L)ocaliza'#231#227'o f'#237'sica'
        CorDestaque = clRed
      end
      object clbEmbQV: TColorLabel
        Left = 42
        Top = 101
        Width = 164
        Height = 14
        Caption = 'Imprimir (Q)uantidade ou (V)olume'
        CorDestaque = clRed
      end
      object clbDocEnd: TColorLabel
        Left = 42
        Top = 155
        Width = 250
        Height = 14
        Caption = 'Ordenar por (D)ocumento (E)ndere'#231'o (R)oteriza'#231#227'o'
        CorDestaque = clRed
      end
      object ckbProdutos: TCheckBox
        Left = 5
        Top = 0
        Width = 153
        Height = 17
        Caption = 'Produtos da Rota'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = ckbProdutosClick
      end
      object edtQtdVol: TEditFocus
        Tag = 99
        Left = 20
        Top = 20
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 1
        Text = 'Q'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object edtDesLoc: TEditFocus
        Tag = 99
        Left = 20
        Top = 44
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 2
        Text = 'D'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object ckbEmbalagens: TCheckBox
        Left = 5
        Top = 77
        Width = 161
        Height = 17
        Caption = 'Embalagens'
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnClick = ckbEmbalagensClick
      end
      object edtEmbQV: TEditFocus
        Tag = 99
        Left = 20
        Top = 97
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 4
        Text = 'Q'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object ckbDocumentos: TCheckBox
        Left = 5
        Top = 129
        Width = 161
        Height = 17
        Caption = 'Documentos da Rota'
        Checked = True
        State = cbChecked
        TabOrder = 5
        OnClick = ckbDocumentosClick
      end
      object ckbTotEspDoc: TCheckBox
        Left = 5
        Top = 196
        Width = 177
        Height = 17
        Caption = 'Total por Esp'#233'cie de Documento'
        TabOrder = 8
      end
      object ckbFormas: TCheckBox
        Left = 5
        Top = 216
        Width = 169
        Height = 17
        Caption = 'Formas de Pagamento'
        Checked = True
        State = cbChecked
        TabOrder = 9
      end
      object ckbInfItem: TCheckBox
        Left = 5
        Top = 234
        Width = 141
        Height = 17
        Caption = 'Informa'#231#245'es dos Itens'
        TabOrder = 10
      end
      object ckbCarCar: TCheckBox
        Left = 5
        Top = 253
        Width = 141
        Height = 17
        Caption = 'Carregamento de Carga'
        TabOrder = 11
      end
      object ckbImpKm: TCheckBox
        Left = 5
        Top = 272
        Width = 141
        Height = 17
        Caption = 'Imprimir KM inicial e final'
        TabOrder = 12
      end
      object edtDocEnd: TEditFocus
        Tag = 99
        Left = 20
        Top = 151
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 6
        Text = 'D'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object chkLocAss: TCheckBox
        Left = 5
        Top = 291
        Width = 244
        Height = 17
        Caption = 'Imprimir local para assinaturas e confer'#234'ncias'
        TabOrder = 13
      end
      object chkRotViagem: TCheckBox
        Left = 5
        Top = 177
        Width = 177
        Height = 17
        Caption = 'Roteiro de Viagem'
        TabOrder = 7
      end
    end
  end
  object GroupBox1: TGroupBox [3]
    Left = 10
    Top = 355
    Width = 304
    Height = 180
    TabOrder = 1
    object clbCliQV: TColorLabel
      Left = 42
      Top = 35
      Width = 164
      Height = 14
      Caption = 'Imprimir (Q)uantidade ou (V)olume'
      Enabled = False
      CorDestaque = clRed
    end
    object clbCliOrd: TColorLabel
      Left = 42
      Top = 55
      Width = 239
      Height = 14
      Caption = 'Ordenar por (D)escri'#231#227'o ou (U)nidade do Produto'
      Enabled = False
      CorDestaque = clRed
    end
    object clbCliOrd2: TColorLabel
      Left = 42
      Top = 66
      Width = 196
      Height = 14
      Caption = '                      Digita'#231#227'o no (F)aturamento'
      Enabled = False
      CorDestaque = clRed
    end
    object ckbItensCli: TCheckBox
      Left = 7
      Top = 11
      Width = 111
      Height = 17
      Caption = 'Itens por Cliente'
      TabOrder = 0
      OnClick = ckbItensCliClick
    end
    object ckbMosMar: TCheckBox
      Left = 21
      Top = 81
      Width = 111
      Height = 17
      Caption = 'Mostra Marca'
      TabOrder = 3
    end
    object edtCliQV: TEditFocus
      Tag = 99
      Left = 21
      Top = 31
      Width = 18
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      MaxLength = 1
      TabOrder = 1
      Text = 'Q'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtCliOrd: TEditFocus
      Tag = 99
      Left = 21
      Top = 55
      Width = 18
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      MaxLength = 1
      TabOrder = 2
      Text = 'D'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object ckbIteDoc: TCheckBox
      Left = 7
      Top = 101
      Width = 130
      Height = 17
      Caption = 'Itens por Documento'
      TabOrder = 4
      OnClick = ckbIteDocClick
    end
    object ckbEndEnt: TCheckBox
      Left = 7
      Top = 139
      Width = 226
      Height = 17
      Caption = 'Itens por Cliente / Endere'#231'o de Entrega'
      TabOrder = 6
      OnClick = ckbEndEntClick
    end
    object chkImpVal: TCheckBox
      Left = 21
      Top = 121
      Width = 226
      Height = 17
      Caption = 'Imprimir Valores no Documento?'
      TabOrder = 5
      OnClick = ckbEndEntClick
    end
    object chkMenExp: TCheckBox
      Left = 21
      Top = 158
      Width = 280
      Height = 17
      Caption = 'Mensagem da Expedi'#231#227'o abaixo de cada documento?'
      TabOrder = 7
      OnClick = ckbEndEntClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 570
    Width = 324
    TabOrder = 3
    ExplicitTop = 570
    ExplicitWidth = 324
    inherited pnlNomeForm: TPanel
      Left = 212
      Width = 112
      ExplicitLeft = 212
      ExplicitWidth = 112
    end
    inherited pnlInfo: TPanel
      Width = 212
      ExplicitWidth = 212
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 184
    Top = 24
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 216
    Top = 24
  end
end
