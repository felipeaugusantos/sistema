inherited frmPedeDadosInterface: TfrmPedeDadosInterface
  Width = 1024
  Height = 750
  Caption = 'Defini'#231#227'o da Interface'
  ExplicitWidth = 1024
  ExplicitHeight = 750
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 677
    Width = 1018
    TabOrder = 2
    ExplicitTop = 677
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
    end
    inherited btnSair: TBitBtnLocked
      Left = 935
      TabOrder = 2
      ExplicitLeft = 935
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 75
      Height = 22
      Caption = '&Confirma'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  inherited pnlStatus: TPanel
    Top = 705
    Width = 1018
    TabOrder = 3
    ExplicitTop = 705
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object pnlDadosGerais: TPanel [2]
    Left = 0
    Top = 0
    Width = 1018
    Height = 257
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 648
      Height = 255
      Align = alLeft
      BevelOuter = bvLowered
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 3
        Width = 49
        Height = 14
        Caption = 'Par'#226'metro'
      end
      object Label2: TLabel
        Left = 198
        Top = 3
        Width = 49
        Height = 14
        Caption = 'Descri'#231#227'o'
      end
      object Label3: TLabel
        Left = 16
        Top = 40
        Width = 82
        Height = 14
        Caption = 'Tipo de Inferface'
      end
      object Label4: TLabel
        Left = 198
        Top = 40
        Width = 82
        Height = 14
        Caption = 'Tipo de Pesquisa'
      end
      object Label5: TLabel
        Left = 16
        Top = 94
        Width = 63
        Height = 14
        Caption = 'Tipo de Dado'
      end
      object lblVerVer: TLabel
        Left = 198
        Top = 94
        Width = 118
        Height = 14
        Caption = 'Sistema Verde Vermelho'
        Enabled = False
      end
      object Label13: TLabel
        Left = 16
        Top = 171
        Width = 388
        Height = 14
        Caption = 
          'Descri'#231#227'o do valor quando o par'#226'metro estiver em branco (valor n' +
          #227'o informado)'
      end
      object lblNroDec: TLabel
        Left = 457
        Top = 171
        Width = 115
        Height = 14
        Caption = 'Quantidade de decimais'
      end
      object Label16: TLabel
        Left = 16
        Top = 212
        Width = 100
        Height = 14
        Caption = 'Descri'#231#227'o do Gatilho'
      end
      object Label17: TLabel
        Left = 17
        Top = 133
        Width = 526
        Height = 14
        Caption = 
          'Express'#227'o que torna a impress'#227'o do filtro vis'#237'vel (para configur' +
          'a'#231#245'es, use o padr'#227'o: fCfgSis('#39'XXXXXX'#39') = '#39'X'#39
      end
      object dbeNomPar: TDBEditFocus
        Left = 16
        Top = 17
        Width = 176
        Height = 22
        TabStop = False
        DataField = 'PAR_NOMPAR'
        DataSource = dtsCadPar
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDesPar: TDBEditFocus
        Left = 198
        Top = 17
        Width = 435
        Height = 22
        DataField = 'PAR_DESPAR'
        DataSource = dtsCadPar
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbePesqui: TDBComboBoxFocus
        Left = 198
        Top = 54
        Width = 435
        Height = 22
        Style = csDropDownList
        DataField = 'PAR_PESQUI'
        DataSource = dtsCadPar
        TabOrder = 3
        OnChange = dbePesquiChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object dbeTipFac: TDBComboBoxFocus
        Left = 16
        Top = 54
        Width = 176
        Height = 22
        Style = csDropDownList
        DataField = 'PAR_TIPFAC'
        DataSource = dtsCadPar
        TabOrder = 2
        OnChange = dbeTipFacChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object dbeTipPar: TDBComboBoxFocus
        Left = 16
        Top = 108
        Width = 176
        Height = 22
        Style = csDropDownList
        DataField = 'PAR_TIPPAR'
        DataSource = dtsCadPar
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object cbxVerVer: TComboBoxFocus
        Tag = 99
        Left = 198
        Top = 108
        Width = 406
        Height = 22
        Style = csDropDownList
        Enabled = False
        TabOrder = 7
        OnChange = cbxVerVerChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object btnDirAce: TBitBtnLocked
        Left = 605
        Top = 105
        Width = 29
        Height = 25
        Hint = 'Incluir novo Direito de Acesso'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000020000000A170D0738542D1894814626D193502AEA924F2AE87F45
          25D0522C17931209053000000009000000010000000000000000000000000000
          00030201011159311B97A96239FAC58957FFD6A36DFFDDAF75FFDDAF74FFD6A4
          6BFFC58956FFA46137F53C2112730000000F0000000300000000000000020201
          0110744226B9BC7C4DFFDDAE77FFDEB076FFE2B782FFE3BB87FFE3BC86FFE1B7
          82FFDEAF74FFDBAB72FFBD7E4EFF6F3E24B50000001000000002000000085C36
          2095BE8053FFE0B37CFFDFB076FFDEB177FFB78254FFAA7144FFAB7245FFBC88
          59FFDFB279FFDFB277FFDEB077FFC08253FF55321D920000000A190F0932B070
          47FADFB27DFFDFB27AFFE0B37BFFE0B57DFFA56B3FFFF5EFEAFFF8F3EEFFAB72
          45FFE2B67EFFE0B47CFFE0B47BFFDEB079FFB3734AFB130B072F613C2795CD9B
          6FFFE2B780FFE5BD89FFE7C291FFE8C393FFA56B3FFFF1E6DEFFF9F5F1FFAA71
          44FFE8C494FFE8C393FFE5BF8CFFE1B77FFFD09C6EFF5434218B935E3DD2DCB3
          83FFE3B781FFBA8659FFA97043FFAB7245FFAC7346FFF5EDE6FFFAF6F3FFAD75
          47FFB0784AFFB17A4BFFC29162FFE4B983FFDEB17EFF8E5B3BD0B0744CF2E3BF
          8FFFE4BB84FFA56B3FFFF3EBE6FFFAF6F3FFF6EFE8FFF7F0EAFFFBF7F5FFFAF7
          F4FFFAF7F3FFFAF6F2FFAB7245FFE5BD87FFE5BE8BFFAB714CEEAE764FECE9C9
          A0FFE5BE89FFA56B3FFFE0D2CAFFE1D3CCFFE3D5CFFFF2EAE4FFF8F3EFFFEADF
          D9FFE6DAD4FFE9DED9FFAA7144FFE7C08CFFEACA9DFFAE764FEE9A6A49D0E9CD
          ACFFEAC796FFB78456FFA56B3FFFA56B3FFFA56B3FFFF1EAE5FFFAF6F3FFA56B
          3FFFA56B3FFFA56B3FFFB78457FFEACA99FFEBD1ADFF996A49D46E4E3697DDBB
          9DFFEED3A9FFEECFA2FFEED2A5FFF0D6A9FFA56B3FFFF0EAE7FFFDFCFBFFA56B
          3FFFF1D6AAFFF0D5A8FFEED2A5FFEFD4A7FFE0C2A2FF6246318F1C140E2BC794
          6CFCF5E8CCFFEFD6ABFFF1D8AEFFF2DAB0FFA56B3FFFDECFC9FFDFD1CBFFA56B
          3FFFF3DCB2FFF1DBB0FFF1D8ADFFF7EACDFFC69470FA1A120D2E000000036F52
          3C92D7B08CFFF8EFD3FFF3E0B9FFF3DFB7FFB98A5FFFA56B3FFFA56B3FFFBA8A
          5FFFF4E1B9FFF4E2BDFFFAF1D5FFD9B390FF664B368C00000006000000010202
          0107906C4EB8D9B38FFFF7EDD3FFF8EED0FFF7EBC9FFF6E8C4FFF6E8C5FFF7EC
          CAFFF8EED0FFF4E8CDFFD7AF8BFF88664AB30202010B00000001000000000000
          00010202010770543F8FCFA078FCE2C4A2FFEBD7B8FFF4E9CDFFF4EACEFFECD8
          B9FFE3C5A3FFC59973F24C392A67000000060000000100000000000000000000
          000000000001000000022019122C6C543E89A47E5FCCC59770F1C19570EEA47E
          60CD6C543F8B16110D2200000003000000010000000000000000}
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
        OnClick = btnDirAceClick
      end
      object dbeSIMPLE: TcxDBCheckBox
        Left = 198
        Top = 75
        Caption = 'Consulta simples (sem multi-sele'#231#227'o)'
        DataBinding.DataField = 'PAR_SIMPLE'
        DataBinding.DataSource = dtsCadPar
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        TabOrder = 4
        OnClick = dbeSIMPLEClick
      end
      object dbeDESTOD: TDBEditFocus
        Left = 16
        Top = 185
        Width = 435
        Height = 22
        DataField = 'PAR_DESTOD'
        DataSource = dtsCadPar
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeNRODEC: TDBEditFocus
        Left = 457
        Top = 185
        Width = 115
        Height = 22
        DataField = 'PAR_NRODEC'
        DataSource = dtsCadPar
        MaxLength = 2
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeDEFEMP: TcxDBCheckBox
        Left = 404
        Top = 75
        Hint = 
          'Com essa op'#231#227'o selecionada, '#233' necess'#225'rio que o filtro de empresa' +
          ' seja obrigat'#243'rio'
        Caption = 'Definir como nome da empresa no relat'#243'rio'
        DataBinding.DataField = 'PAR_DEFEMP'
        DataBinding.DataSource = dtsCadPar
        ParentShowHint = False
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        ShowHint = True
        TabOrder = 5
      end
      object dbeDesGat: TDBEditFocus
        Left = 16
        Top = 226
        Width = 435
        Height = 22
        DataField = 'PAR_DESGAT'
        DataSource = dtsCadPar
        TabOrder = 12
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeEXPIMP: TDBMemoFocus
        Left = 16
        Top = 148
        Width = 617
        Height = 22
        DataField = 'PAR_EXPIMP'
        DataSource = dtsCadPar
        ScrollBars = ssVertical
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
    end
    object Panel2: TPanel
      Left = 649
      Top = 1
      Width = 368
      Height = 255
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 1
      object pnlCheckBox: TPanel
        Left = 1
        Top = 207
        Width = 366
        Height = 73
        Align = alTop
        BevelOuter = bvLowered
        TabOrder = 0
        object Label6: TLabel
          Left = 15
          Top = 7
          Width = 70
          Height = 14
          Caption = 'Valor checado'
        end
        object Label7: TLabel
          Left = 172
          Top = 7
          Width = 91
          Height = 14
          Caption = 'Valor n'#227'o checado'
        end
        object dbeValChk: TDBEditFocus
          Left = 15
          Top = 20
          Width = 154
          Height = 22
          DataField = 'PAR_VALCHK'
          DataSource = dtsCadPar
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeValNch: TDBEditFocus
          Left = 172
          Top = 20
          Width = 154
          Height = 22
          DataField = 'PAR_VALNCH'
          DataSource = dtsCadPar
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeChkDef: TcxDBCheckBox
          Left = 15
          Top = 43
          Caption = 'Valor "default" checado'
          DataBinding.DataField = 'PAR_CHKDEF'
          DataBinding.DataSource = dtsCadPar
          Properties.ValueChecked = 'S'
          Properties.ValueUnchecked = 'N'
          TabOrder = 2
        end
      end
      object pnlDadosBasicos: TPanel
        Left = 1
        Top = 335
        Width = 366
        Height = 65
        Align = alTop
        BevelOuter = bvLowered
        TabOrder = 1
        Visible = False
        object Label12: TLabel
          Left = 15
          Top = 15
          Width = 61
          Height = 14
          Caption = 'Valor default'
        end
        object DBEditFocus2: TDBEditFocus
          Left = 15
          Top = 28
          Width = 185
          Height = 22
          DataField = 'PAR_VALDEF'
          DataSource = dtsCadPar
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlLimChk: TPanel
        Left = 1
        Top = 280
        Width = 366
        Height = 55
        Align = alTop
        BevelOuter = bvLowered
        TabOrder = 2
        Visible = False
        object Label14: TLabel
          Left = 15
          Top = 7
          Width = 135
          Height = 14
          Caption = 'Limite de itens selecionados'
        end
        object Label15: TLabel
          Left = 167
          Top = 7
          Width = 188
          Height = 14
          Caption = 'Limite de itens para gera'#231#227'o em retrato'
        end
        object dbeLimChk: TDBEditFocus
          Left = 15
          Top = 20
          Width = 66
          Height = 22
          DataField = 'PAR_LIMCHK'
          DataSource = dtsCadPar
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeLimRet: TDBEditFocus
          Left = 167
          Top = 20
          Width = 66
          Height = 22
          DataField = 'PAR_LIMRET'
          DataSource = dtsCadPar
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlFiltrosPesquisa: TPanel
        Left = 1
        Top = 1
        Width = 366
        Height = 206
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 3
        object Panel6: TPanel
          Left = 0
          Top = 0
          Width = 366
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Filtros para a pesquisa'
          TabOrder = 0
        end
        object cxgFiltros: TcxGrid
          Left = 0
          Top = 22
          Width = 366
          Height = 184
          Align = alClient
          TabOrder = 1
          object cxvFiltros: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = '<Nenhuma parametriza'#231#227'o dispon'#237'vel>'
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            object cxvFiltrosFILTRO: TcxGridDBColumn
              Caption = 'Filtro'
              DataBinding.FieldName = 'NOMFIL'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Width = 161
            end
            object cxvFiltrosEXPRES: TcxGridDBColumn
              Caption = 'Valor do Filtro'
              DataBinding.FieldName = 'EXPRES'
              Width = 181
            end
          end
          object cxgFiltrosLevel1: TcxGridLevel
            GridView = cxvFiltros
          end
        end
      end
    end
  end
  object pnlComboBox: TPanel [3]
    Left = 0
    Top = 257
    Width = 1018
    Height = 200
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 1
    object Label8: TLabel
      Left = 15
      Top = 16
      Width = 96
      Height = 14
      Caption = 'Lista de Descri'#231#245'es'
    end
    object Label9: TLabel
      Left = 271
      Top = 16
      Width = 78
      Height = 14
      Caption = 'Lista de Valores'
    end
    object Label10: TLabel
      Left = 535
      Top = 16
      Width = 94
      Height = 14
      Caption = 'Descri'#231#227'o "Default"'
    end
    object dbeFacTxt: TDBMemoFocus
      Left = 15
      Top = 30
      Width = 250
      Height = 156
      DataField = 'PAR_FACTXT'
      DataSource = dtsCadPar
      ScrollBars = ssBoth
      TabOrder = 0
      OnExit = dbeFacTxtExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object dbeFacVal: TDBMemoFocus
      Left = 271
      Top = 30
      Width = 250
      Height = 156
      DataField = 'PAR_FACVAL'
      DataSource = dtsCadPar
      ScrollBars = ssBoth
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object dbeValDef: TDBComboBoxFocus
      Left = 535
      Top = 30
      Width = 250
      Height = 22
      Style = csDropDownList
      DataField = 'PAR_VALDEF'
      DataSource = dtsCadPar
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object gpbTabPre: TGroupBox
      Left = 535
      Top = 58
      Width = 250
      Height = 99
      Caption = 'Tabelas de Pre'#231'o'
      TabOrder = 3
      object Label11: TLabel
        Left = 15
        Top = 48
        Width = 98
        Height = 14
        Caption = 'Descri'#231#227'o da Tabela'
      end
      object dbeTabAti: TcxDBCheckBox
        Left = 11
        Top = 20
        Caption = 'Completar com as Tabelas de Pre'#231'o Ativas'
        DataBinding.DataField = 'PAR_TABATI'
        DataBinding.DataSource = dtsCadPar
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        TabOrder = 0
      end
      object DBEditFocus1: TDBEditFocus
        Left = 15
        Top = 62
        Width = 185
        Height = 22
        DataField = 'PAR_DESATI'
        DataSource = dtsCadPar
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object gpbConfigComboBox: TGroupBox
      Left = 795
      Top = 16
      Width = 210
      Height = 170
      Caption = 'Configura'#231#227'o x ComboBox'
      TabOrder = 4
      object Label18: TLabel
        Left = 10
        Top = 17
        Width = 33
        Height = 14
        Caption = 'C'#243'digo'
      end
      object Label19: TLabel
        Left = 10
        Top = 58
        Width = 87
        Height = 14
        Caption = 'Tipo configura'#231#227'o'
      end
      object Label20: TLabel
        Left = 10
        Top = 100
        Width = 154
        Height = 14
        Caption = 'Filtrar Empresa (Ex. ":CODEMP")'
      end
      object dbeCODCFG: TDBEditFocus
        Left = 10
        Top = 33
        Width = 191
        Height = 22
        DataField = 'PAR_CODCFG'
        DataSource = dtsCadPar
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeVALCFG: TcxDBCheckBox
        Left = 6
        Top = 141
        Caption = 'Buscar CADVAL se CFG tiver valor'
        DataBinding.DataField = 'PAR_VALCFG'
        DataBinding.DataSource = dtsCadPar
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        TabOrder = 3
      end
      object dbeTIPCFG: TDBComboBoxFocus
        Left = 10
        Top = 74
        Width = 191
        Height = 22
        Style = csDropDownList
        DataField = 'PAR_TIPCFG'
        DataSource = dtsCadPar
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object dbeEMPCFG: TDBEditFocus
        Left = 10
        Top = 116
        Width = 191
        Height = 22
        DataField = 'PAR_EMPCFG'
        DataSource = dtsCadPar
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
  end
  object pnlVisible: TPanel [4]
    Left = 0
    Top = 457
    Width = 1018
    Height = 220
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    object Panel3: TPanel
      Left = 0
      Top = 281
      Width = 1018
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Caption = 
        'Express'#227'o que torna o par'#226'metro vis'#237'vel (definir uma express'#227'o q' +
        'ue retorne TRUE ou FALSE baseada em outros par'#226'metros)'
      TabOrder = 0
    end
    object bceSQLVIS: TBCEditor
      Left = 0
      Top = 202
      Width = 1018
      Height = 79
      Cursor = crIBeam
      ActiveLine.Indicator.Visible = False
      Align = alTop
      BorderStyle = bsNone
      Caret.Options = []
      CodeFolding.Hint.Font.Charset = DEFAULT_CHARSET
      CodeFolding.Hint.Font.Color = clWindowText
      CodeFolding.Hint.Font.Height = -11
      CodeFolding.Hint.Font.Name = 'Courier New'
      CodeFolding.Hint.Font.Style = []
      CodeFolding.Hint.Indicator.Glyph.Visible = False
      CompletionProposal.CloseChars = '()[]. '
      CompletionProposal.Columns = <
        item
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          Items = <>
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Courier New'
          Title.Font.Style = []
        end>
      CompletionProposal.SecondaryShortCut = 0
      CompletionProposal.ShortCut = 16416
      CompletionProposal.Trigger.Chars = '.'
      CompletionProposal.Trigger.Enabled = False
      Directories.Colors = 'Colors'
      Directories.Highlighters = 'Highlighters'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      LeftMargin.Font.Charset = DEFAULT_CHARSET
      LeftMargin.Font.Color = 13408665
      LeftMargin.Font.Height = -11
      LeftMargin.Font.Name = 'Courier New'
      LeftMargin.Font.Style = []
      Lines.Strings = (
        '')
      LineSpacing = 0
      MatchingPair.Enabled = True
      Minimap.Font.Charset = DEFAULT_CHARSET
      Minimap.Font.Color = clWindowText
      Minimap.Font.Height = -1
      Minimap.Font.Name = 'Courier New'
      Minimap.Font.Style = []
      SpecialChars.Style = scsDot
      SyncEdit.ShortCut = 24650
      TabOrder = 1
      TokenInfo.Font.Charset = DEFAULT_CHARSET
      TokenInfo.Font.Color = clWindowText
      TokenInfo.Font.Height = -11
      TokenInfo.Font.Name = 'Courier New'
      TokenInfo.Font.Style = []
      TokenInfo.Title.Font.Charset = DEFAULT_CHARSET
      TokenInfo.Title.Font.Color = clWindowText
      TokenInfo.Title.Font.Height = -11
      TokenInfo.Title.Font.Name = 'Courier New'
      TokenInfo.Title.Font.Style = []
      UndoOptions = [uoGroupUndo]
      WordWrap.Indicator.Bitmap.Data = {
        02020000424D020200000000000042000000280000000F0000000E0000000100
        100003000000C001000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C00001F7C1F7C000000000000000000001F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C10001F7C1F7C
        1F7C1F7C00001F7C1F7C0000000000001F7C1F7C1F7C1F7C100010001F7C1F7C
        1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C10001000100010001000
        1F7C1F7C00001F7C1F7C0000000000001F7C1F7C1F7C1F7C100010001F7C1F7C
        10001F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C10001F7C1F7C
        10001F7C00001F7C1F7C000000000000000000001F7C1F7C1F7C1F7C1F7C1F7C
        10001F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        10001F7C00001F7C1F7C1F7C1F7C1F7C1F7C1000100010001000100010001000
        1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C0000}
      WordWrap.Indicator.MaskColor = clFuchsia
    end
    object Panel4: TPanel
      Left = 0
      Top = 177
      Width = 1018
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Caption = 
        'Express'#227'o que torna o par'#226'metro vis'#237'vel (defnir um SQL que retor' +
        'na TRUE ou FALSE)'
      TabOrder = 2
    end
    object dbeExpVis: TDBMemoFocus
      Left = 0
      Top = 306
      Width = 1018
      Height = 66
      Align = alClient
      DataField = 'PAR_EXPVIS'
      DataSource = dtsCadPar
      ScrollBars = ssVertical
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object pnlSQLCHK: TPanel
      Left = 0
      Top = 0
      Width = 1018
      Height = 177
      Align = alTop
      BevelOuter = bvLowered
      TabOrder = 4
      object Panel5: TPanel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 1010
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        Caption = 'SQL para montagem da lista'
        TabOrder = 0
      end
      object bceSQLCHK: TBCEditor
        Left = 1
        Top = 32
        Width = 1016
        Height = 144
        Cursor = crIBeam
        ActiveLine.Indicator.Visible = False
        Align = alClient
        BorderStyle = bsNone
        Caret.Options = []
        CodeFolding.Hint.Font.Charset = DEFAULT_CHARSET
        CodeFolding.Hint.Font.Color = clWindowText
        CodeFolding.Hint.Font.Height = -11
        CodeFolding.Hint.Font.Name = 'Courier New'
        CodeFolding.Hint.Font.Style = []
        CodeFolding.Hint.Indicator.Glyph.Visible = False
        CompletionProposal.CloseChars = '()[]. '
        CompletionProposal.Columns = <
          item
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            Items = <>
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Courier New'
            Title.Font.Style = []
          end>
        CompletionProposal.SecondaryShortCut = 0
        CompletionProposal.ShortCut = 16416
        CompletionProposal.Trigger.Chars = '.'
        CompletionProposal.Trigger.Enabled = False
        Directories.Colors = 'Colors'
        Directories.Highlighters = 'Highlighters'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        LeftMargin.Font.Charset = DEFAULT_CHARSET
        LeftMargin.Font.Color = 13408665
        LeftMargin.Font.Height = -11
        LeftMargin.Font.Name = 'Courier New'
        LeftMargin.Font.Style = []
        Lines.Strings = (
          '')
        LineSpacing = 0
        MatchingPair.Enabled = True
        Minimap.Font.Charset = DEFAULT_CHARSET
        Minimap.Font.Color = clWindowText
        Minimap.Font.Height = -1
        Minimap.Font.Name = 'Courier New'
        Minimap.Font.Style = []
        SpecialChars.Style = scsDot
        SyncEdit.ShortCut = 24650
        TabOrder = 1
        TokenInfo.Font.Charset = DEFAULT_CHARSET
        TokenInfo.Font.Color = clWindowText
        TokenInfo.Font.Height = -11
        TokenInfo.Font.Name = 'Courier New'
        TokenInfo.Font.Style = []
        TokenInfo.Title.Font.Charset = DEFAULT_CHARSET
        TokenInfo.Title.Font.Color = clWindowText
        TokenInfo.Title.Font.Height = -11
        TokenInfo.Title.Font.Name = 'Courier New'
        TokenInfo.Title.Font.Style = []
        UndoOptions = [uoGroupUndo]
        WordWrap.Indicator.Bitmap.Data = {
          02020000424D020200000000000042000000280000000F0000000E0000000100
          100003000000C001000000000000000000000000000000000000007C0000E003
          00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C00001F7C1F7C000000000000000000001F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C10001F7C1F7C
          1F7C1F7C00001F7C1F7C0000000000001F7C1F7C1F7C1F7C100010001F7C1F7C
          1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C10001000100010001000
          1F7C1F7C00001F7C1F7C0000000000001F7C1F7C1F7C1F7C100010001F7C1F7C
          10001F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C10001F7C1F7C
          10001F7C00001F7C1F7C000000000000000000001F7C1F7C1F7C1F7C1F7C1F7C
          10001F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          10001F7C00001F7C1F7C1F7C1F7C1F7C1F7C1000100010001000100010001000
          1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C0000}
        WordWrap.Indicator.MaskColor = clFuchsia
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 928
    Top = 312
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 832
    Top = 360
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 928
    Top = 240
  end
  object dtsCadPar: TDataSource
    Left = 833
    Top = 237
  end
end
