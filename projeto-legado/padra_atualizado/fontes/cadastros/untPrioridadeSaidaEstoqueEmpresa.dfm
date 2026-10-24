inherited frmPrioridadeSaidaEstoqueEmpresa: TfrmPrioridadeSaidaEstoqueEmpresa
  Width = 1001
  Height = 499
  BorderIcons = [biSystemMenu]
  Caption = 'Prioridade de sa'#237'da do estoque por empresa'
  Position = poMainFormCenter
  ExplicitWidth = 1001
  ExplicitHeight = 499
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 426
    Width = 995
    TabOrder = 3
    ExplicitTop = 426
    ExplicitWidth = 995
    inherited FlwBotoes: TFlowPanel
      Width = 991
      ExplicitWidth = 991
      object btnGravar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 90
        Height = 22
        Caption = '&Gravar'
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
        OnClick = btnGravarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 912
      ExplicitLeft = 912
    end
  end
  inherited pnlStatus: TPanel
    Top = 454
    Width = 995
    TabOrder = 4
    ExplicitTop = 454
    ExplicitWidth = 995
    inherited pnlNomeForm: TPanel
      Left = 745
      Width = 250
      ExplicitLeft = 745
      ExplicitWidth = 250
    end
    inherited pnlInfo: TPanel
      Width = 745
      ExplicitWidth = 745
    end
  end
  object pnlEmpresaLogadaParaVenda: TPanel [2]
    Left = 0
    Top = 0
    Width = 995
    Height = 30
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblCodEmp: TLabel
      Left = 4
      Top = 7
      Width = 143
      Height = 14
      Caption = 'Empresa Logada para Venda:'
    end
    object lblItem: TLabel
      Left = 642
      Top = 7
      Width = 22
      Height = 14
      Caption = 'Item:'
      Visible = False
    end
    object edtDesEmp: TEditFocus
      Left = 223
      Top = 4
      Width = 411
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmp: TEditFocus
      Left = 164
      Top = 4
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 1
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtItem: TEditFocus
      Left = 666
      Top = 4
      Width = 323
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 2
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlPrioridadeSaidaEstoque: TPanel [3]
    Left = 0
    Top = 80
    Width = 995
    Height = 346
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label3: TLabel
      Left = 1
      Top = 1
      Width = 993
      Height = 16
      Align = alTop
      Alignment = taCenter
      Caption = 'Prioridade na Sa'#237'da do Estoque'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 202
    end
    object grdPrioridade: TcxGrid
      Left = 1
      Top = 17
      Width = 978
      Height = 312
      Align = alClient
      TabOrder = 0
      object grdPrioridadeDBTableView: TcxGridDBTableView
        OnKeyDown = grdPrioridadeDBTableViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsPrioridade
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = '< Sem dados para exibir >'
        OptionsView.GroupByBox = False
        object grdPrioridadeDBTableViewAUTINC: TcxGridDBColumn
          Caption = 'Autoincremento'
          DataBinding.FieldName = 'AUTINC'
          Visible = False
          Width = 101
        end
        object grdPrioridadeDBTableViewCODEMP: TcxGridDBColumn
          Caption = 'C'#243'd. Emp. Logada'
          DataBinding.FieldName = 'CODEMP'
          Visible = False
          Width = 100
        end
        object grdPrioridadeDBTableViewDESEMP: TcxGridDBColumn
          Caption = 'Emp. Logada'
          DataBinding.FieldName = 'DESEMP'
          Visible = False
          Width = 295
        end
        object grdPrioridadeDBTableViewEMPSAI: TcxGridDBColumn
          Caption = 'C'#243'd. Emp. Sa'#237'da'
          DataBinding.FieldName = 'EMPSAI'
          Width = 92
        end
        object grdPrioridadeDBTableViewDESSAI: TcxGridDBColumn
          Caption = 'Emp. Sa'#237'da'
          DataBinding.FieldName = 'DESSAI'
          Width = 351
        end
        object grdPrioridadeDBTableViewARMSAI: TcxGridDBColumn
          Caption = 'C'#243'd. Armaz'#233'm'
          DataBinding.FieldName = 'ARMSAI'
          Width = 93
        end
        object grdPrioridadeDBTableViewDESARM: TcxGridDBColumn
          AlternateCaption = '400'
          Caption = 'Armaz'#233'm'
          DataBinding.FieldName = 'DESARM'
          Width = 418
        end
        object grdPrioridadeDBTableViewORDEM: TcxGridDBColumn
          Caption = 'Ordem'
          DataBinding.FieldName = 'ORDEM'
          Visible = False
        end
      end
      object grdPrioridadeLevel1: TcxGridLevel
        GridView = grdPrioridadeDBTableView
      end
    end
    object pnlLegenda: TPanel
      Left = 1
      Top = 329
      Width = 993
      Height = 16
      Align = alBottom
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = 
        'Para excluir uma empresa pressione delete ap'#243's selecionar o regi' +
        'stro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      Visible = False
    end
    object pnlBotGri: TPanel
      Left = 979
      Top = 17
      Width = 15
      Height = 312
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 2
      object btnPgDown: TSpeedButton
        Left = 0
        Top = 290
        Width = 15
        Height = 22
        Hint = 'Prioridade (-)'
        Align = alBottom
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000FF8000FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000FF
          8000FF8000FF8000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF8000FF8000FF8000FF8000FF8000FF8000FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000FF8000FF8000FF
          8000FF8000FF8000FF8000FF8000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF80
          00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000FF8000FF8000FF8000FF8000FF
          8000FF8000FF8000FF8000FF8000FF8000FF8000FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF8000FF8000FF8000FF8000FF8000FF8000FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000FF8000FF
          8000FF8000FF8000FF8000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF8000FF8000FF8000FF8000FF8000FF8000FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000FF8000FF
          8000FF8000FF8000FF8000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF8000FF8000FF8000FF8000FF8000FF8000FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000FF8000FF
          8000FF8000FF8000FF8000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF8000FF8000FF8000FF8000FF8000FF8000FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000FF8000FF
          8000FF8000FF8000FF8000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        ParentShowHint = False
        ShowHint = True
        OnClick = btnPgDownClick
        ExplicitLeft = 8
        ExplicitTop = 248
        ExplicitWidth = 23
      end
      object btnPgUp: TSpeedButton
        Left = 0
        Top = 0
        Width = 15
        Height = 22
        Hint = 'Prioridade (+)'
        Align = alTop
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF8000FF8000FF8000FF8000FF8000FF8000FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000FF8000FF
          8000FF8000FF8000FF8000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF8000FF8000FF8000FF8000FF8000FF8000FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000FF8000FF
          8000FF8000FF8000FF8000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF8000FF8000FF8000FF8000FF8000FF8000FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000FF8000FF
          8000FF8000FF8000FF8000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF8000FF8000FF8000FF8000FF8000FF8000FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000FF8000FF
          8000FF8000FF8000FF8000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF80
          00FF8000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000FF8000FF8000FF8000FF
          8000FF8000FF8000FF8000FF8000FF8000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000FF8000FF
          8000FF8000FF8000FF8000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF8000FF8000FF8000FF8000FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          8000FF8000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        ParentShowHint = False
        ShowHint = True
        OnClick = btnPgUpClick
        ExplicitLeft = 8
        ExplicitTop = 248
        ExplicitWidth = 23
      end
    end
  end
  object pnlEmpresaParaSaidaDeEstoque: TPanel [4]
    Left = 0
    Top = 30
    Width = 995
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    object lblEmpSai: TLabel
      Left = 4
      Top = 5
      Width = 156
      Height = 14
      Caption = 'Empresa para sa'#237'da de estoque:'
    end
    object edtDesSai: TEditFocus
      Left = 223
      Top = 2
      Width = 411
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtEmpSai: TEditFocus
      Left = 164
      Top = 2
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = edtEmpSaiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object btnAdicionar: TBitBtnLocked
      Left = 638
      Top = 2
      Width = 104
      Height = 22
      Caption = '&Confirma'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
        609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
        D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
        9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
        95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
        8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
        A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
        A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
        E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
        B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
        ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
        E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
        BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
        27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
        EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
        C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
        C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
        8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
        CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
        D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
        FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
        CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
        68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 2
      OnClick = btnAdicionarClick
    end
  end
  object pnlArmazem: TPanel [5]
    Left = 0
    Top = 55
    Width = 995
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 5
    Visible = False
    object lblArmSai: TLabel
      Left = 3
      Top = 4
      Width = 160
      Height = 14
      Caption = 'Armaz'#233'm para sa'#237'da de estoque:'
    end
    object edtDesArm: TEditFocus
      Left = 223
      Top = 1
      Width = 411
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtArmSai: TEditFocus
      Left = 164
      Top = 1
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = edtArmSaiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 840
    Top = 70
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 808
    Top = 70
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 872
    Top = 70
  end
  object cdsPrioridade: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 744
    Top = 70
    object cdsPrioridadeAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsPrioridadeCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsPrioridadeDESEMP: TStringField
      FieldName = 'DESEMP'
      Size = 70
    end
    object cdsPrioridadeEMPSAI: TStringField
      FieldName = 'EMPSAI'
      Size = 3
    end
    object cdsPrioridadeDESSAI: TStringField
      FieldName = 'DESSAI'
      Size = 70
    end
    object cdsPrioridadeARMSAI: TStringField
      FieldName = 'ARMSAI'
      Size = 3
    end
    object cdsPrioridadeDESARM: TStringField
      FieldName = 'DESARM'
      Size = 70
    end
    object cdsPrioridadeORDEM: TIntegerField
      FieldName = 'ORDEM'
    end
  end
  object dtsPrioridade: TDataSource
    DataSet = cdsPrioridade
    Left = 776
    Top = 70
  end
end
