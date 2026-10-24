inherited frmRecTransfEstoque: TfrmRecTransfEstoque
  Left = 172
  Top = 122
  Width = 873
  Height = 600
  BorderIcons = [biSystemMenu]
  Caption = 'Entrada de Mercadorias Simplificada (entre lojas)'
  Position = poMainFormCenter
  ExplicitWidth = 873
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 494
    Width = 857
    Height = 51
    ExplicitTop = 494
    ExplicitWidth = 857
    ExplicitHeight = 51
    DesignSize = (
      857
      51)
    object Label1: TLabel [0]
      Left = 288
      Top = 30
      Width = 325
      Height = 14
      Alignment = taCenter
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
      Width = 853
      Height = 47
      ExplicitWidth = 853
      ExplicitHeight = 47
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 142
        ExplicitWidth = 142
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 142
        Width = 142
        ExplicitLeft = 142
        ExplicitWidth = 142
      end
      object btnGravar: TBitBtnLocked
        Left = 284
        Top = 0
        Width = 142
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
        TabOrder = 2
        OnClick = BitBtnLocked1Click
      end
      object btnMarca: TBitBtnLocked
        Left = 426
        Top = 0
        Width = 142
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
        TabOrder = 3
        OnClick = btnMarcaClick
      end
      object btnDesmarca: TBitBtnLocked
        Left = 568
        Top = 0
        Width = 142
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
        TabOrder = 4
        OnClick = btnDesmarcaClick
      end
      object btnItens: TBitBtnLocked
        Left = 710
        Top = 0
        Width = 142
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
        TabOrder = 5
        OnClick = btnItensClick
      end
      object btnConferenciaColetor: TBitBtnLocked
        Left = 0
        Top = 22
        Width = 284
        Height = 22
        Caption = '[ F9 ] Manuten'#231#227'o Confer'#234'ncia Coletor'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000C2B1E19D136251FFF36251FFF35241EFF32221DFF32221DFF3524
          1EFF36251FFF36251FFF2B1E19D10000000C0000000000000000000000000000
          00000000000D372620FF46342DFF45322BFF423029FF867C78FF867C78FF4230
          29FF45322BFF46342DFF372620FF0000000D0000000000000000000000000000
          00000000000D392821FF4A372FFF4A372FFF48362EFF47352DFF47352DFF4836
          2EFF4A372FFF4A372FFF392821FF0000000D0000000000000000000000000000
          00000000000D3B2A23FF926041FFA56B45FFA56B45FFA46B45FFA46B45FFA56B
          45FFA56B45FF926041FF3B2A23FF0000000D0000000000000000000000000000
          00000000000D3E2B24FFA9714BFFDDAF77FFDDAF77FFDDAF77FFDDAF77FFDDAF
          77FFDDAF77FFA9714BFF3E2B24FF0000000D0000000000000000000000000000
          00000000000D402D26FFAD7752FFDFB57FFFDFB57FFFDFB57FFFDFB57FFFDFB5
          7FFFDFB57FFFAD7752FF402D26FF0000000D0000000000000000000000000000
          00000000000D432F28FFB17E59FFE2BB87FFE2BB87FFE2BB87FFE2BB87FFE2BB
          87FFE2BB87FFB17E59FF432F28FF0000000D0000000000000000000000000000
          00000000000D45312AFFB68560FFE5C292FFE7C597FFE7C699FFE7C698FFE6C4
          96FFE5C292FFB68560FF45312AFF0000000D0000000000000000000000000000
          00000000000D513D35FFC59D7DFFEDD3ADFFEDD3ADFFEDD3ADFFEDD3ADFFEDD3
          ADFFEDD3ADFFC59D7DFF513D35FF0000000D0000000000000000000000000000
          00000201010D6E5D57FFCCA98BFFF0D8B3FFF0D8B3FFF0D8B3FFF0D8B3FFF0D8
          B3FFF0D8B3FFCCA98BFF6E5D57FF0201010D0000000000000000000000000000
          00000303030D705F59FFCFAD91FFF1DDB9FFF1DDB9FFF1DDB9FFF1DDB9FFF1DD
          B9FFF1DDB9FFCFAD91FF705F59FF0303030D0000000000000000000000000000
          00000303030D726059FFD2B295FFF3E1BEFFF3E1BFFFF3E1BFFFF3E1BFFFF3E1
          BFFFF3E1BEFFD2B295FF726059FF0303030D0000000000000000000000000000
          00000303030D74615BFFCAAD94FFD5B699FFD5B79AFFD5B89BFFD5B89BFFD5B7
          9AFFD5B699FFCAAD94FF74615BFF0303030D0000000000000000000000000000
          00000202020C75635CFFAA9389FFAA9389FF8D7971FF6D5D57FF6D5D57FF8D79
          71FFAA9389FFAA9389FF75635CFF0202020C0000000000000000000000000000
          00000202020876645DFFAE978DFFAD968CFFAD968CFFAD968CFFAD968CFFAD96
          8CFFAD968CFFAE978DFF76645DFF020202080000000000000000000000000000
          0000000000025E4F49C978655DFF78655DFF78655DFF78655DFF78655DFF7865
          5DFF78655DFF78655DFF5E4F4ACA010101030000000000000000}
        TabOrder = 6
        OnClick = btnConferenciaColetorClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 712
      Top = 25
      Width = 142
      ExplicitLeft = 712
      ExplicitTop = 25
      ExplicitWidth = 142
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 857
    ExplicitTop = 545
    ExplicitWidth = 857
    inherited pnlNomeForm: TPanel
      Left = 686
      ExplicitLeft = 686
    end
    inherited pnlInfo: TPanel
      Width = 686
      ExplicitWidth = 686
    end
  end
  inherited pnlHeader: TPanel
    Width = 857
    Height = 55
    Font.Height = -11
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
    ExplicitWidth = 857
    ExplicitHeight = 55
    object mmoNotifica: TMemo
      Left = 0
      Top = 0
      Width = 857
      Height = 55
      TabStop = False
      Align = alClient
      Color = clInfoBk
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      Lines.Strings = (
        ''
        
          '         A entrada simplificada n'#227'o far'#225' atualiza'#231#227'o de pre'#231'os p' +
          'ara produtos que estejam cadastrados em d'#243'lar.')
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
  end
  inherited pnlTail: TPanel
    Top = 446
    Width = 857
    Visible = True
    ExplicitTop = 446
    ExplicitWidth = 857
    object Label2: TLabel
      Left = 5
      Top = 6
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Mensagem:'
    end
    object Label3: TLabel
      Left = 11
      Top = 29
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Operador:'
    end
    object dbeMen001: TDBEditFocus
      Left = 64
      Top = 2
      Width = 377
      Height = 22
      TabStop = False
      Color = 16770261
      DataField = 'GER_MEN001'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeMen002: TDBEditFocus
      Left = 443
      Top = 2
      Width = 377
      Height = 22
      TabStop = False
      Color = 16770261
      DataField = 'GER_MEN002'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodDig: TDBEditFocus
      Left = 64
      Top = 25
      Width = 57
      Height = 22
      TabStop = False
      Color = 16770261
      DataField = 'OPE_CODOPE'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeNomDig: TDBEditFocus
      Left = 122
      Top = 25
      Width = 319
      Height = 22
      TabStop = False
      Color = 16770261
      DataField = 'GER_NOMDIG'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 95
    Width = 857
    Height = 321
    Color = clWhite
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    Columns = <
      item
        Expanded = False
        FieldName = 'GER_CODCON'
        ReadOnly = True
        Title.Caption = 'C'#243'd. Conf.'
        Width = 60
        Visible = True
      end
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
        Width = 114
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_NUMFAT'
        Title.Caption = 'Doc. Conf.'
        Width = 120
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
        FieldName = 'GER_NOMEMP'
        Title.Caption = 'Nome da Empresa (Origem)'
        Width = 260
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
    Top = 55
    Width = 857
    ExplicitTop = 55
    ExplicitWidth = 857
    inherited lblPesquisa: TLabel
      Top = 13
      ExplicitTop = 13
    end
    inherited lblNomeCampo: TLabel
      Top = 13
      ExplicitTop = 13
    end
    inherited edtData: TMaskEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtNumero: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtString: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtValor: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
  end
  object pnlLegendas: TPanel [6]
    Left = 0
    Top = 416
    Width = 857
    Height = 30
    Align = alBottom
    TabOrder = 6
    object Shape1: TShape
      Left = 5
      Top = 8
      Width = 15
      Height = 15
      Brush.Color = clSkyBlue
    end
    object Label4: TLabel
      Left = 23
      Top = 8
      Width = 110
      Height = 14
      Caption = 'Confirma'#231#227'o de TEs'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pnlLegendaColetor: TPanel
      Left = 139
      Top = 1
      Width = 431
      Height = 28
      BevelOuter = bvNone
      TabOrder = 0
      object lblColetor: TLabel
        Left = 209
        Top = 7
        Width = 212
        Height = 14
        Caption = 'Confer'#234'ncia em andamento no coletor'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object shpConferenciaAndamendo: TShape
        Left = 191
        Top = 7
        Width = 15
        Height = 15
        Brush.Color = 9699327
      end
      object Label5: TLabel
        Left = 17
        Top = 7
        Width = 168
        Height = 14
        Caption = 'Conf'#234'ncia finalizada no coletor'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object shpConferenciaFinalizada: TShape
        Left = 0
        Top = 7
        Width = 14
        Height = 15
        Brush.Color = 10354589
      end
    end
    object pnlLegendaConferencia: TPanel
      Left = 570
      Top = 1
      Width = 209
      Height = 28
      BevelOuter = bvNone
      TabOrder = 1
      object lblConferenciaAguardando: TLabel
        Left = 17
        Top = 7
        Width = 137
        Height = 14
        Caption = 'Aguardando Confer'#234'ncia'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object shpConferenciaAguardando: TShape
        Left = 0
        Top = 7
        Width = 14
        Height = 15
        Brush.Color = clLime
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 296
    Top = 176
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 176
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Top = 200
  end
  inherited qryConsulta: TUniQuery
    Left = 136
    Top = 176
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 168
    Top = 176
  end
  inherited cdsConsulta: TUniClientDataSet
    Left = 200
    Top = 176
  end
  inherited dtsConsulta: TDataSource
    Left = 232
    Top = 176
  end
  object qryPedido: TUniQuery
    Connection = frmModulo.Database
    Left = 720
    Top = 288
  end
  object dspPedido: TUniDataSetProvider
    DataSet = qryPedido
    Options = []
    Left = 752
    Top = 288
  end
  object cdsPedido: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPedido'
    Left = 784
    Top = 288
  end
end
