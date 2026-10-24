inherited frmRcxTransfDocs: TfrmRcxTransfDocs
  Left = 239
  Top = 246
  Width = 795
  Height = 400
  ActiveControl = dbgConsulta
  Caption = ''
  ExplicitWidth = 795
  ExplicitHeight = 400
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 319
    Width = 779
    Height = 26
    ExplicitTop = 319
    ExplicitWidth = 779
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 698
      Height = 22
      ExplicitWidth = 698
      ExplicitHeight = 22
      inherited btnPesquisar: TBitBtnLocked
        Width = 102
        ExplicitWidth = 102
      end
      object btnGravar: TBitBtnLocked
        Left = 220
        Top = 0
        Width = 116
        Height = 22
        Caption = '[ F10 ] Confirma'
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
        TabOrder = 2
        OnClick = btnGravarClick
      end
      object btnMarcaTodos: TBitBtnLocked
        Left = 336
        Top = 0
        Width = 116
        Height = 22
        Caption = '[ F6 ] Marca Todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          555555555555555555555555555555555555555555FF55555555555559055555
          55555555577FF5555555555599905555555555557777F5555555555599905555
          555555557777FF5555555559999905555555555777777F555555559999990555
          5555557777777FF5555557990599905555555777757777F55555790555599055
          55557775555777FF5555555555599905555555555557777F5555555555559905
          555555555555777FF5555555555559905555555555555777FF55555555555579
          05555555555555777FF5555555555557905555555555555777FF555555555555
          5990555555555555577755555555555555555555555555555555}
        NumGlyphs = 2
        TabOrder = 3
        OnClick = btnMarcaTodosClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 452
        Top = 0
        Width = 141
        Height = 22
        Caption = '[ F7 ] Desmarca Todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
          3333333777333777FF3333993333339993333377FF3333377FF3399993333339
          993337777FF3333377F3393999333333993337F777FF333337FF993399933333
          399377F3777FF333377F993339993333399377F33777FF33377F993333999333
          399377F333777FF3377F993333399933399377F3333777FF377F993333339993
          399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
          99333773FF3333777733339993333339933333773FFFFFF77333333999999999
          3333333777333777333333333999993333333333377777333333}
        NumGlyphs = 2
        TabOrder = 4
        OnClick = btnDesmarcaTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 700
      Top = 2
      Align = alRight
      ExplicitLeft = 700
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 345
    Width = 779
    ExplicitTop = 345
    ExplicitWidth = 779
    inherited pnlNomeForm: TPanel
      Left = 608
      ExplicitLeft = 608
    end
    inherited pnlInfo: TPanel
      Width = 608
      ExplicitWidth = 608
    end
  end
  inherited pnlHeader: TPanel
    Width = 779
    Height = 11
    Visible = False
    ExplicitWidth = 779
    ExplicitHeight = 11
  end
  inherited pnlTail: TPanel
    Top = 291
    Width = 779
    Height = 28
    Visible = True
    ExplicitTop = 291
    ExplicitWidth = 779
    ExplicitHeight = 28
    object Label1: TLabel
      Left = 489
      Top = 8
      Width = 54
      Height = 14
      Caption = 'Total Geral:'
    end
    object Label2: TLabel
      Left = 144
      Top = 8
      Width = 93
      Height = 14
      Caption = 'Total Selecionados:'
    end
    object edtTotSel: TEditFocus
      Left = 242
      Top = 3
      Width = 92
      Height = 22
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 0
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtTotGer: TEditFocus
      Left = 549
      Top = 3
      Width = 92
      Height = 22
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 1
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 51
    Width = 779
    Height = 240
    Columns = <
      item
        Expanded = False
        FieldName = 'BANCO'
        Title.Caption = 'Banco'
        Width = 34
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AGENCIA'
        Title.Caption = 'Ag'#234'ncia'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CONTA'
        Title.Caption = 'N'#186' Conta'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUMERO'
        Title.Caption = 'N'#186' Cheque'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODCLI'
        Title.Caption = 'C'#243'd. Cliente'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMEMI'
        Title.Caption = 'Nome'
        Width = 247
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR'
        Title.Caption = 'Valor'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTACAD'
        Title.Caption = 'Cadastro'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTAVEN'
        Title.Caption = 'Vencimento'
        Width = 60
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 11
    Width = 779
    ExplicitTop = 11
    ExplicitWidth = 779
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 440
    Top = 152
  end
  inherited qryConsulta: TUniQuery
    Left = 152
    Top = 152
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 184
    Top = 152
  end
  inherited cdsConsulta: TUniClientDataSet
    Left = 216
    Top = 152
  end
  inherited dtsConsulta: TDataSource
    Left = 248
    Top = 152
  end
  object cdsTotais: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Filter = 'MARDES = '#39'M'#39
    Params = <>
    Left = 216
    Top = 192
  end
end
