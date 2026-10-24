inherited frmFatAltComissao: TfrmFatAltComissao
  Left = 482
  Top = 194
  Width = 893
  Height = 473
  Caption = 'Altera'#231#227'o de Comiss'#227'o'
  Position = poMainFormCenter
  ExplicitWidth = 893
  ExplicitHeight = 473
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlStatus: TPanel [0]
    Top = 428
    Width = 887
    TabOrder = 3
    ExplicitTop = 428
    ExplicitWidth = 887
    inherited pnlInfo: TPanel [0]
      Width = 716
      ExplicitWidth = 716
    end
    inherited pnlNomeForm: TPanel [1]
      Left = 716
      ExplicitLeft = 716
    end
  end
  object pnlBusca: TPanel [1]
    Left = 0
    Top = 0
    Width = 887
    Height = 70
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    DesignSize = (
      887
      70)
    object lblDoc: TLabel
      Left = 9
      Top = 19
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
    end
    object lblEmp: TLabel
      Left = 21
      Top = 45
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object lblEsp: TLabel
      Left = 194
      Top = 17
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie:'
    end
    object edtDocum: TEditFocus
      Tag = 99
      Left = 68
      Top = 15
      Width = 120
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 12
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 68
      Top = 41
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 2
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 237
      Top = 13
      Width = 28
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 2
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtDesEmp: TEditFocus
      Left = 125
      Top = 41
      Width = 747
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      Color = 16768952
      ReadOnly = True
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
  object pnlDados: TPanel [2]
    Left = 0
    Top = 70
    Width = 887
    Height = 200
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    Enabled = False
    TabOrder = 1
    DesignSize = (
      887
      200)
    object Label1: TLabel
      Left = 11
      Top = 7
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label2: TLabel
      Left = 11
      Top = 44
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Dt.Emiss'#227'o:'
    end
    object Label6: TLabel
      Left = 78
      Top = 44
      Width = 104
      Height = 14
      Alignment = taRightJustify
      Caption = 'Condi'#231#227'o Pagamento:'
    end
    object lblVenAtu: TLabel
      Left = 13
      Top = 81
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor Atual:'
    end
    object Label7: TLabel
      Left = 12
      Top = 155
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Documento:'
    end
    object lblRepAtu: TLabel
      Left = 12
      Top = 118
      Width = 101
      Height = 14
      Alignment = taRightJustify
      Caption = 'Representante Atual:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 11
      Top = 21
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 5
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDtaFat: TEditFocus
      Tag = 99
      Left = 11
      Top = 58
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 3
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtConPag: TEditFocus
      Tag = 99
      Left = 77
      Top = 58
      Width = 795
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      Color = 16768952
      MaxLength = 12
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesCli: TEditFocus
      Left = 77
      Top = 21
      Width = 795
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      Color = 16768952
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesVen: TEditFocus
      Tag = 99
      Left = 77
      Top = 95
      Width = 795
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      Color = 16768952
      MaxLength = 12
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtValDoc: TEditFocus
      Tag = 99
      Left = 11
      Top = 169
      Width = 95
      Height = 22
      Alignment = taRightJustify
      Color = 16768952
      MaxLength = 12
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 11
      Top = 95
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 3
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtCodRep: TEditFocus
      Tag = 99
      Left = 11
      Top = 132
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 3
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesRep: TEditFocus
      Tag = 99
      Left = 77
      Top = 132
      Width = 795
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      Color = 16768952
      MaxLength = 12
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlComissao: TPanel [3]
    Left = 0
    Top = 270
    Width = 887
    Height = 132
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 5
    ExplicitHeight = 130
    object dbgProdutos: TDBGridCitel
      Left = 2
      Top = 2
      Width = 883
      Height = 128
      Hint = 
        'ESC: Voltar ao c'#243'digo do item'#13#10'ENTER: Alterar Item'#13#10'DELETE: Dele' +
        'ta o item'#13#10'CTRL + CIMA: Mover item para cima'#13#10'CTRL + BAIXO: Move' +
        'r item para baixo'
      Align = alClient
      DataSource = dtsProdutos
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnKeyDown = dbgProdutosKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'CODITE'
          ReadOnly = True
          Title.Caption = 'C'#243'd. Item'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRI'
          ReadOnly = True
          Title.Caption = 'Descri'#231#227'o'
          Width = 180
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UNIDAD'
          ReadOnly = True
          Title.Caption = 'Uni.'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QTDITE'
          ReadOnly = True
          Title.Caption = 'Qtde.'
          Width = 58
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UNITAR'
          ReadOnly = True
          Title.Caption = 'Unit'#225'rio'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TOTITE'
          ReadOnly = True
          Title.Caption = 'Total (- Desc.)'
          Width = 76
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CODVEN'
          ReadOnly = True
          Title.Caption = 'C'#243'd. Ven.'
          Title.Color = 10944511
          Width = 55
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PERCOM'
          Title.Caption = 'Comiss'#227'o %'
          Title.Color = 10944511
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TOTCOM'
          ReadOnly = True
          Title.Caption = 'Comiss'#227'o R$'
          Title.Color = 10944511
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CODREP'
          ReadOnly = True
          Title.Caption = 'C'#243'd. Rep.'
          Title.Color = 13434828
          Width = 55
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PERREP'
          Title.Caption = 'Comiss'#227'o %'
          Title.Color = 13434828
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COMREP'
          ReadOnly = True
          Title.Caption = 'Comiss'#227'o R$'
          Title.Color = 13434828
          Width = 70
          Visible = True
        end>
    end
  end
  inherited pnlBotoes: TPanel
    Top = 402
    Width = 887
    Height = 26
    TabOrder = 4
    ExplicitTop = 402
    ExplicitWidth = 887
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 806
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 883
      ExplicitHeight = 24
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 77
        Height = 22
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
        OnClick = btnConfirmaClick
      end
      object btnComVenTodos: TBitBtnLocked
        Left = 77
        Top = 0
        Width = 161
        Height = 22
        Caption = '[F8] Repassar Com. Vendedor'
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnComVenTodosClick
      end
      object btnComRepTodos: TBitBtnLocked
        Left = 238
        Top = 0
        Width = 189
        Height = 22
        Caption = '[F9] Repassar Com. Representante'
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnComVenTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 808
      Top = 2
      Align = alRight
      ExplicitLeft = 806
      ExplicitTop = 2
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 728
    Top = 32
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 760
    Top = 32
  end
  object cdsProdutos: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    BeforePost = cdsProdutosBeforePost
    AfterPost = cdsProdutosAfterPost
    AfterCancel = cdsProdutosAfterCancel
    AfterScroll = cdsProdutosAfterScroll
    Left = 511
    Top = 235
    object cdsProdutosCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsProdutosDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 101
    end
    object cdsProdutosUNIDAD: TStringField
      FieldName = 'UNIDAD'
      Size = 2
    end
    object cdsProdutosQTDITE: TFloatField
      FieldName = 'QTDITE'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsProdutosUNITAR: TFloatField
      DisplayLabel = 'QTDITE'
      FieldName = 'UNITAR'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsProdutosTOTITE: TFloatField
      DisplayLabel = 'QTDITE'
      FieldName = 'TOTITE'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsProdutosCODVEN: TStringField
      FieldName = 'CODVEN'
      Size = 3
    end
    object cdsProdutosPERCOM: TFloatField
      DisplayLabel = 'QTDITE'
      FieldName = 'PERCOM'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsProdutosTOTCOM: TFloatField
      DisplayLabel = 'QTDITE'
      FieldName = 'TOTCOM'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsProdutosCODREP: TStringField
      FieldName = 'CODREP'
      Size = 3
    end
    object cdsProdutosPERREP: TFloatField
      DisplayLabel = 'QTDITE'
      FieldName = 'PERREP'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsProdutosCOMREP: TFloatField
      DisplayLabel = 'QTDITE'
      FieldName = 'COMREP'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsProdutosTABELA: TStringField
      FieldName = 'TABELA'
      Size = 10
    end
    object cdsProdutosAUTINC: TStringField
      FieldName = 'AUTINC'
    end
  end
  object dtsProdutos: TDataSource
    DataSet = cdsProdutos
    Left = 541
    Top = 235
  end
end
