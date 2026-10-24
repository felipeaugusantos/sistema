inherited frmCadEmpresasHeranca: TfrmCadEmpresasHeranca
  Left = 0
  Top = 0
  Width = 932
  Height = 548
  BorderIcons = [biSystemMenu]
  Caption = 'Tabelas\Campos para Heran'#231'a na Cria'#231#227'o da Nova Empresa'
  DockSite = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OldCreateOrder = False
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 932
  ExplicitHeight = 548
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Top = 475
    Width = 926
    ExplicitTop = 475
    ExplicitWidth = 926
    inherited FlwBotoes: TFlowPanel
      Width = 922
      ExplicitWidth = 922
    end
    inherited btnSair: TBitBtnLocked
      Left = 845
      Top = 2
      ExplicitLeft = 845
      ExplicitTop = 2
    end
    object btnConfirma: TBitBtnLocked
      Left = 7
      Top = 2
      Width = 112
      Height = 22
      Caption = '[F10] Confirmar'
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
      ModalResult = 1
      TabOrder = 2
      WordWrap = True
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 503
    Width = 926
    ExplicitTop = 503
    ExplicitWidth = 926
    inherited pnlNomeForm: TPanel
      Left = 755
      ExplicitLeft = 755
    end
    inherited pnlInfo: TPanel
      Width = 755
      ExplicitWidth = 755
    end
  end
  object PageControl1: TPageControl [2]
    Left = 0
    Top = 0
    Width = 926
    Height = 475
    ActivePage = TabSheet2
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 2
    TabStop = False
    object TabSheet1: TTabSheet
      Caption = 'Tabelas a herdar'
      object cxGridCitel1: TcxGridCitel
        Left = 0
        Top = 0
        Width = 918
        Height = 404
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdHeranca: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnEditKeyPress = grdHerancaEditKeyPress
          DataController.DataSource = dtsHeranca
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object grdHerancaColumn1: TcxGridDBColumn
            Caption = 'Herdar?'
            DataBinding.FieldName = 'HER_CHECKD'
            Width = 70
          end
          object grdHerancaColumn2: TcxGridDBColumn
            Caption = 'Tarefa'
            DataBinding.FieldName = 'HER_DESCRI'
            Options.Editing = False
            Width = 319
          end
          object grdHerancaColumn3: TcxGridDBColumn
            Caption = 'Empresa Origem'
            DataBinding.FieldName = 'HER_EMPORI'
            Width = 97
          end
        end
        object cxGridCitel1Level1: TcxGridLevel
          GridView = grdHeranca
        end
      end
      object pnlObservacoes: TPanel
        Left = 0
        Top = 404
        Width = 918
        Height = 40
        Align = alBottom
        TabOrder = 1
        object lblInformacao: TLabel
          AlignWithMargins = True
          Left = 6
          Top = 6
          Width = 906
          Height = 28
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alClient
          Caption = 
            'Observa'#231#227'o: As seguintes tabelas [TABELAS], ser'#227'o herdadas do ba' +
            'nco f'#237'sico caso a "Empresa Origem" informada utilize replica'#231#227'o.' +
            ' Ser'#225' utilizado para isso o IP prim'#225'rio e IP secund'#225'rio da respe' +
            'ctiva empresa.'
          WordWrap = True
          ExplicitWidth = 904
          ExplicitHeight = 26
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Direitos de Acesso'
      ImageIndex = 1
      object Label1: TLabel
        Left = 50
        Top = 12
        Width = 66
        Height = 13
        Caption = 'Acesso Geral:'
      end
      object Label2: TLabel
        Left = 29
        Top = 39
        Width = 87
        Height = 13
        Caption = 'Acesso Individual:'
      end
      object chkAcesso: TCheckListBox
        Left = 39
        Top = 63
        Width = 441
        Height = 55
        Columns = 2
        ItemHeight = 13
        Items.Strings = (
          'Login'
          'Acesso'
          'Inclus'#227'o/Baixa de Romaneio'
          'Baixa Contas a Receber'
          'Baixa de Contas  a Pagar'
          'Estoque')
        TabOrder = 6
      end
      object btnAddDireitoAcesso: TBitBtnLocked
        Left = 484
        Top = 96
        Width = 84
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
        TabOrder = 7
        OnClick = btnAddDireitoAcessoClick
      end
      object cxGridCitel2: TcxGridCitel
        Left = 0
        Top = 136
        Width = 918
        Height = 308
        Align = alBottom
        TabOrder = 8
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxGridDBTableViewCitel1: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnEditKeyPress = grdHerancaEditKeyPress
          DataController.DataSource = dtsDireitoAcesso
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxGridDBColumn1: TcxGridDBColumn
            Caption = 'Usu'#225'rio'
            DataBinding.FieldName = 'DIR_NOMOPE'
            Options.Editing = False
            SortIndex = 0
            SortOrder = soAscending
            Width = 272
          end
          object cxGridDBColumn2: TcxGridDBColumn
            Caption = 'Login'
            DataBinding.FieldName = 'DIR_EMPLOG'
            Width = 70
          end
          object cxGridDBColumn3: TcxGridDBColumn
            Caption = 'Acesso'
            DataBinding.FieldName = 'DIR_EMPACE'
            Width = 70
          end
          object cxGridDBColumn4: TcxGridDBColumn
            Caption = 'Inclus'#227'o\Baixa de Romaneio'
            DataBinding.FieldName = 'DIR_EMPROM'
            Width = 144
          end
          object cxGridDBColumn5: TcxGridDBColumn
            Caption = 'Baixa de Contas a Receber'
            DataBinding.FieldName = 'DIR_EMPCTR'
            Width = 144
          end
          object cxGridDBColumn6: TcxGridDBColumn
            Caption = 'Baixa de Contas a Pagar'
            DataBinding.FieldName = 'DIR_EMPCTP'
            Width = 128
          end
          object cxGridDBColumn7: TcxGridDBColumn
            Caption = 'Estoque'
            DataBinding.FieldName = 'DIR_EMPEST'
            Width = 70
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDBTableViewCitel1
        end
      end
      object chkAcessoGeralTodos: TCheckBox
        Left = 484
        Top = 11
        Width = 53
        Height = 17
        Caption = 'Todos'
        TabOrder = 2
        OnClick = chkAcessoGeralTodosClick
      end
      object chkAcessoIndividualTodos: TCheckBox
        Left = 484
        Top = 38
        Width = 53
        Height = 17
        Caption = 'Todos'
        TabOrder = 5
        OnClick = chkAcessoIndividualTodosClick
      end
      object edtCodGpo: TEditFocus
        Tag = 99
        Left = 120
        Top = 9
        Width = 65
        Height = 21
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 3
        TabOrder = 0
        OnKeyPress = edtCodGpoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDscGpo: TEditFocus
        Left = 188
        Top = 9
        Width = 290
        Height = 21
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodOpe: TEditFocus
        Tag = 99
        Left = 120
        Top = 36
        Width = 65
        Height = 21
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 3
        TabOrder = 3
        OnKeyPress = edtCodOpeKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtNomOpe: TEditFocus
        Left = 188
        Top = 36
        Width = 290
        Height = 21
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Condi'#231#245'es de Pagamento'
      ImageIndex = 2
      object Label3: TLabel
        Left = 37
        Top = 14
        Width = 120
        Height = 13
        Caption = 'Condi'#231#227'o de Pagamento:'
      end
      object btnAddCondicaoPagamento: TBitBtnLocked
        Left = 596
        Top = 10
        Width = 84
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
        TabOrder = 3
        OnClick = btnAddCondicaoPagamentoClick
      end
      object cxGridCitel3: TcxGridCitel
        Left = 0
        Top = 44
        Width = 918
        Height = 400
        Align = alBottom
        TabOrder = 4
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxGridDBTableViewCitel2: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnEditKeyPress = grdHerancaEditKeyPress
          DataController.DataSource = dtsCondicaoPagamento
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxGridDBColumn8: TcxGridDBColumn
            Caption = 'Condi'#231#227'o de Pagamento'
            DataBinding.FieldName = 'CND_NOMCND'
            Options.Editing = False
            SortIndex = 0
            SortOrder = soAscending
            Width = 503
          end
        end
        object cxGridLevel2: TcxGridLevel
          GridView = cxGridDBTableViewCitel2
        end
      end
      object chkCondicaoPagamentoTodos: TCheckBox
        Left = 526
        Top = 13
        Width = 53
        Height = 17
        Caption = 'Todas'
        TabOrder = 2
        OnClick = chkCondicaoPagamentoTodosClick
      end
      object edtCodCnd: TEditFocus
        Tag = 99
        Left = 160
        Top = 11
        Width = 65
        Height = 21
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 3
        TabOrder = 0
        OnKeyPress = edtCodCndKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtDscCnd: TEditFocus
        Left = 230
        Top = 11
        Width = 290
        Height = 21
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 1
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
  inherited mnuAuxiliar: TPopupMenu
    Left = 736
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 784
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 760
    Top = 8
  end
  object dtsHeranca: TDataSource
    Left = 16
    Top = 32
  end
  object dtsDireitoAcesso: TDataSource
    Left = 48
    Top = 200
  end
  object dtsCondicaoPagamento: TDataSource
    Left = 872
    Top = 216
  end
end
