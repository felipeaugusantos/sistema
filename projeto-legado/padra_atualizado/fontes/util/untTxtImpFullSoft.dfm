inherited frmTxtImpFullSoft: TfrmTxtImpFullSoft
  Left = 298
  Top = 134
  Width = 391
  Height = 570
  BorderIcons = [biSystemMenu]
  Caption = 'TXTs - Full Soft - Importa'#231#227'o'
  Position = poScreenCenter
  OnClose = FormClose
  ExplicitWidth = 391
  ExplicitHeight = 570
  PixelsPerInch = 96
  TextHeight = 14
  object Label17: TLabel [0]
    Left = 6
    Top = 4
    Width = 107
    Height = 14
    Caption = 'Path Importa'#231#227'o TXTs:'
  end
  inherited pnlBotoes: TPanel
    Top = 498
    Width = 385
    TabOrder = 2
    ExplicitTop = 498
    ExplicitWidth = 385
    DesignSize = (
      385
      28)
    inherited btnSair: TBitBtnLocked
      Left = 302
      TabOrder = 2
      ExplicitLeft = 302
    end
    object btnImporta: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 77
      Height = 22
      Caption = '&Importar'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
        333333333337F33333333333333033333333333333373F333333333333090333
        33333333337F7F33333333333309033333333333337373F33333333330999033
        3333333337F337F33333333330999033333333333733373F3333333309999903
        333333337F33337F33333333099999033333333373333373F333333099999990
        33333337FFFF3FF7F33333300009000033333337777F77773333333333090333
        33333333337F7F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333300033333333333337773333333}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnImportaClick
    end
    object btnGravar: TBitBtnLocked
      Left = 81
      Top = 3
      Width = 77
      Height = 22
      Caption = '&Gravar'
      Enabled = False
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
      TabOrder = 1
      OnClick = btnGravarClick
    end
  end
  object pgDados: TPageControl [3]
    Left = 6
    Top = 47
    Width = 372
    Height = 440
    ActivePage = tbLogImp
    MultiLine = True
    Style = tsFlatButtons
    TabOrder = 1
    object tbImportar: TTabSheet
      Caption = 'Importar'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object barEspecifico: TGauge
        Left = 3
        Top = 387
        Width = 358
        Height = 16
        ForeColor = 16777151
        Progress = 0
      end
      object chkLstItensExportar: TCheckListBox
        Left = 3
        Top = 5
        Width = 358
        Height = 374
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ItemHeight = 14
        TabOrder = 0
      end
    end
    object tbDados: TTabSheet
      Caption = 'Dados'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object gpItens: TGroupBox
        Left = 0
        Top = 108
        Width = 364
        Height = 195
        Align = alClient
        Caption = 'Itens'
        TabOrder = 1
        object dbgPedidosItens: TDBGridCitel
          Left = 2
          Top = 16
          Width = 360
          Height = 177
          Align = alClient
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = 14
          TitleFont.Name = 'Arial'
          TitleFont.Pitch = fpVariable
          TitleFont.Style = []
          OnKeyPress = dbgPedidosItensKeyPress
          Columns = <
            item
              Expanded = False
              FieldName = 'CODIGOPRODUTO'
              Title.Caption = 'C'#243'digo'
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'QUANTIDADE'
              Title.Caption = 'Quantidade'
              Width = 78
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRECOVENDA'
              Title.Caption = 'Valor'
              Width = 78
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCONTO'
              Title.Caption = 'Desconto'
              Width = 59
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SALDO'
              Title.Caption = 'Saldo'
              Width = 67
              Visible = True
            end>
        end
      end
      object gbPedidos: TGroupBox
        Left = 0
        Top = 0
        Width = 364
        Height = 108
        Align = alTop
        Caption = 'Pedidos'
        TabOrder = 0
        object dbgPedidos: TDBGridCitel
          Left = 2
          Top = 16
          Width = 360
          Height = 90
          Align = alClient
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = 14
          TitleFont.Name = 'Arial'
          TitleFont.Pitch = fpVariable
          TitleFont.Style = []
          OnDrawColumnCell = dbgPedidosDrawColumnCell
          OnDblClick = dbgPedidosDblClick
          OnKeyPress = dbgPedidosKeyPress
          Columns = <
            item
              Expanded = False
              FieldName = 'NUMEROPEDIDO'
              Title.Caption = 'Pedido'
              Width = 46
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATAPEDIDO'
              Title.Caption = 'Data'
              Width = 62
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ORDEMCOMPRA'
              Title.Caption = 'Ord. Compra'
              Width = 66
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CPFCNPJ'
              Title.Caption = 'Cliente'
              Width = 89
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TOTALVENDA'
              Title.Caption = 'Total'
              Width = 70
              Visible = True
            end>
        end
      end
      object gbClientes: TGroupBox
        Left = 0
        Top = 303
        Width = 364
        Height = 105
        Align = alBottom
        Caption = 'Clientes'
        TabOrder = 2
        object dbgContatos: TDBGridCitel
          Left = 2
          Top = 16
          Width = 360
          Height = 87
          Align = alClient
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = 14
          TitleFont.Name = 'Arial'
          TitleFont.Pitch = fpVariable
          TitleFont.Style = []
          OnKeyPress = dbgContatosKeyPress
          Columns = <
            item
              Expanded = False
              FieldName = 'CODIGO'
              Title.Caption = 'C'#243'digo'
              Width = 54
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CNPJ'
              Title.Caption = 'CPF/CNPJ'
              Width = 90
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NOMECLIENTE'
              Title.Caption = 'Nome'
              Width = 163
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'TIPMANUT'
              Title.Alignment = taCenter
              Title.Caption = 'Tipo'
              Width = 25
              Visible = True
            end>
        end
      end
    end
    object tbLogImp: TTabSheet
      Caption = 'Informa'#231#245'es'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object mmoLogImp: TMemo
        Left = 0
        Top = 0
        Width = 364
        Height = 408
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
    end
  end
  object dirPathExp: TFilenameEditFocus [4]
    Left = 6
    Top = 19
    Width = 372
    Height = 22
    TabOrder = 0
    Text = ''
    OnExit = dirPathExpExit
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
  end
  inherited pnlStatus: TPanel
    Top = 526
    Width = 385
    TabOrder = 3
    ExplicitTop = 526
    ExplicitWidth = 385
    inherited pnlNomeForm: TPanel
      Left = 214
      ExplicitLeft = 214
    end
    inherited pnlInfo: TPanel
      Width = 214
      ExplicitWidth = 214
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 268
    Top = 192
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 236
    Top = 192
  end
end
