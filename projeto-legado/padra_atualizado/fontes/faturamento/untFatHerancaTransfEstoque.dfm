inherited frmFatHerancaTransfEstoque: TfrmFatHerancaTransfEstoque
  Left = 172
  Top = 122
  Width = 818
  Height = 408
  Caption = 'Heran'#231'a de Transfer'#234'ncias de Estoque'
  Position = poMainFormCenter
  ExplicitWidth = 818
  ExplicitHeight = 408
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 288
    Width = 802
    Height = 49
    ExplicitTop = 288
    ExplicitWidth = 802
    ExplicitHeight = 49
    object Label1: TLabel [0]
      Left = 8
      Top = 5
      Width = 325
      Height = 14
      Caption = 'Pressione Enter para marcar ou desmarcar um documento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Top = 24
      Width = 798
      Height = 23
      Align = alBottom
      ExplicitTop = 24
      ExplicitWidth = 798
      ExplicitHeight = 23
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 115
        Spacing = 2
        ExplicitWidth = 115
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 115
        Width = 105
        Spacing = 2
        ExplicitLeft = 115
        ExplicitWidth = 105
      end
      object btnGravar: TBitBtnLocked
        Left = 220
        Top = 0
        Width = 105
        Height = 22
        Caption = '[ F10 ] &Confirma'
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
        Spacing = 2
        TabOrder = 2
        OnClick = btnGravarClick
      end
      object btnItens: TBitBtnLocked
        Left = 325
        Top = 0
        Width = 128
        Height = 22
        Caption = '[ F6 ] Produtos da TE'
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          04000000000080000000120B0000120B00001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF00C0C0C00000FFFF00FF000000C0C0C000FFFF0000FFFFFF00DADADADADADA
          DADAADADADADADADADAD00000000000ADADA003333333330ADAD0B0333333333
          0ADA0FB03333333330AD0BFB03333333330A0FBFB000000000000BFBFBFBFB0A
          DADA0FBFBFBFBF0DADAD0BFB0000000ADADAA000ADADADAD000DDADADADADADA
          D00AADADADAD0DAD0D0DDADADADAD000DADAADADADADADADADAD}
        Spacing = 2
        TabOrder = 3
        OnClick = btnItensClick
      end
      object btnMarca: TBitBtnLocked
        Left = 453
        Top = 0
        Width = 118
        Height = 22
        Caption = '[ F7 ] Marcar Todos'
        Glyph.Data = {
          F2010000424DF201000000000000F20000002800000010000000100000000100
          08000000000000010000340B0000340B00002F0000002F000000EA8F3100B66A
          5000AB735800C07B5800EAA15800FFB65800AB6A6000B67B6000C08460006A6A
          6A00A16A6A00A1736A00C0846A006AFF6A00A17B7300B68F7B00F4C07B00B68F
          8400F4C08400F4CA8400B6988F00C0988F00F4CA8F00B6AB9800F4CA9800D4AB
          A100D4B6A100E0B6A100EAB6A100EAC0A100F4D4A100FFD4A100EAC0AB00F4D4
          AB00F4E0B600E0C0C000E0CAC000E0CACA00F4E0CA00FFEACA00FFEAD400FFF4
          E000FFF4EA00FFF4F400FFFFF400FF00FF00FFFFFF002D2D0A0A0A0A0A0A0A0A
          0A0A0A0A0A2D2D2D112722211E181612101010130A2D2D2D1127090909090909
          090909120A2D2D2D14290D0D0D0D0D0D0D0D0D120A2D2D2D14290D0D0D0D0D0D
          0D0D0D100A2D2D2D142C090909090909090909120A2D2D2D1A2E0D0D0D0D0D0D
          0D0D0D0D0A2D2D2D1A2E0D0D0D0D0D0D0D0D0D0D0A2D2D2D1A2E090909090909
          0909091E0A2D2D2D192E0D0D0D0D0D0D0D0D0D1E0A2D2D2D1A2E0D0D0D0D0D0D
          0D0D0D170A2D2D2D1B2E09090909092A260F0E0B0A2D2D2D1B2E0D0D0D0D0D0D
          23020400012D2D2D202E0D0D0D0D0D0D240705032D2D2D2D1B2B2A2A2A2A2A2A
          23070C2D2D2D2D2D1B1D1D1D1D1B1B1D19062D2D2D2D}
        Spacing = 2
        TabOrder = 4
        OnClick = btnMarcaClick
      end
      object btnDesmarca: TBitBtnLocked
        Left = 571
        Top = 0
        Width = 141
        Height = 22
        Caption = '[ F8 ] Desmarcar Todos'
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          04000000000080000000120B0000120B00001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF00C0C0C00000FFFF00FF000000C0C0C000FFFF0000FFFFFF00DADAD7000007
          DADAADAD019999910DADDAD09999999990DAAD0999999999990DD71999999999
          9917A0999FF999FF9990D09999FF9FF99990A099999FFF999990D099999FFF99
          9990A09999FF9FF99990D7199FF999FF9917AD0999999999990DDAD099999999
          90DAADAD019999910DADDADAD7000007DADAADADADADADADADAD}
        Spacing = 2
        TabOrder = 5
        OnClick = btnDesmarcaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 723
      Top = 24
      Width = 75
      Anchors = [akTop, akRight]
      Spacing = 2
      ExplicitLeft = 723
      ExplicitTop = 24
      ExplicitWidth = 75
    end
  end
  inherited pnlHeader: TPanel
    Width = 802
    Height = 1
    Visible = False
    ExplicitWidth = 802
    ExplicitHeight = 1
  end
  inherited pnlTail: TPanel
    Top = 288
    Width = 802
    Height = 0
    ExplicitTop = 288
    ExplicitWidth = 802
    ExplicitHeight = 0
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 41
    Width = 802
    Height = 247
    ReadOnly = True
    Columns = <
      item
        Expanded = False
        FieldName = 'GER_DTAENT'
        Title.Caption = 'Data Emiss'#227'o'
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_DOCUME'
        Title.Caption = 'Documento'
        Width = 116
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_CODEMP'
        Title.Caption = 'Emp.Origem'
        Width = 62
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMP_NOMEMP'
        Title.Caption = 'Nome da Empresa (Origem)'
        Width = 406
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_VLRCON'
        Title.Alignment = taCenter
        Title.Caption = 'Valor Documento'
        Width = 96
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 1
    Width = 802
    ExplicitTop = 1
    ExplicitWidth = 802
  end
  object pgbGravando: TProgressBar [6]
    Left = 0
    Top = 337
    Width = 802
    Height = 16
    Align = alBottom
    Smooth = True
    TabOrder = 6
    Visible = False
  end
  inherited pnlStatus: TPanel
    Top = 353
    Width = 802
    ExplicitTop = 353
    ExplicitWidth = 802
    inherited pnlNomeForm: TPanel
      Left = 631
      ExplicitLeft = 631
    end
    inherited pnlInfo: TPanel
      Width = 631
      ExplicitWidth = 631
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 376
    Top = 112
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 344
    Top = 112
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 272
    Top = 136
  end
  inherited qryConsulta: TUniQuery
    Left = 216
    Top = 112
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 248
    Top = 112
  end
  inherited cdsConsulta: TUniClientDataSet
    Left = 280
    Top = 112
  end
  inherited dtsConsulta: TDataSource
    Left = 312
    Top = 112
  end
end
