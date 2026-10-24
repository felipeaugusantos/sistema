inherited frmRelatorioAcompanhamentoPix: TfrmRelatorioAcompanhamentoPix
  Width = 991
  Height = 576
  Caption = 'Relat'#243'rio do Log de Acompanhamento da Cobran'#231'a Pix'
  Position = poScreenCenter
  WindowState = wsMaximized
  ExplicitWidth = 991
  ExplicitHeight = 576
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 503
    Width = 985
    ExplicitTop = 503
    ExplicitWidth = 985
    inherited FlwBotoes: TFlowPanel
      Width = 904
      ExplicitWidth = 904
    end
    inherited btnSair: TBitBtnLocked
      Left = 906
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 906
      ExplicitTop = 2
      ExplicitHeight = 24
    end
  end
  inherited pnlStatus: TPanel
    Top = 531
    Width = 985
    ExplicitTop = 531
    ExplicitWidth = 985
    inherited pnlNomeForm: TPanel
      Left = 814
      ExplicitLeft = 814
    end
    inherited pnlInfo: TPanel
      Width = 814
      ExplicitWidth = 814
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 985
    Height = 503
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object pnlHeader: TPanel
      Left = 1
      Top = 1
      Width = 983
      Height = 54
      Align = alTop
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 0
      DesignSize = (
        983
        54)
      object lblDocumento: TLabel
        Left = 16
        Top = 22
        Width = 57
        Height = 14
        Alignment = taRightJustify
        Caption = 'Documento:'
      end
      object lblEmpresa: TLabel
        Left = 278
        Top = 22
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresa:'
      end
      object lblEspecie: TLabel
        Left = 189
        Top = 22
        Width = 41
        Height = 14
        Alignment = taRightJustify
        Caption = 'Esp'#233'cie:'
      end
      object lblCliente: TLabel
        Left = 386
        Top = 22
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente:'
      end
      object edtDocumento: TEditFocus
        Tag = 99
        Left = 79
        Top = 19
        Width = 104
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 12
        TipoTexto = ttAlfanumerico
      end
      object edtEmpresa: TEditFocus
        Tag = 99
        Left = 329
        Top = 19
        Width = 41
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ReadOnly = True
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtEspecie: TEditFocus
        Tag = 99
        Left = 233
        Top = 19
        Width = 33
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 2
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 2
        TipoTexto = ttAlfanumerico
      end
      object grpLegendaCores: TGroupBox
        Left = 838
        Top = 4
        Width = 140
        Height = 40
        Anchors = [akTop, akRight]
        Caption = 'Legenda de cores'
        TabOrder = 3
        StyleElements = [seFont, seBorder]
        object shpLegendaAlterados: TShape
          Left = 16
          Top = 18
          Width = 25
          Height = 14
          Brush.Color = 8417535
        end
        object lblDescricaoAlterados: TLabel
          Left = 47
          Top = 18
          Width = 87
          Height = 14
          Caption = 'Campos alterados'
        end
      end
      object edtCliente: TEditFocus
        Tag = 99
        Left = 427
        Top = 19
        Width = 270
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        ReadOnly = True
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 12
        TipoTexto = ttAlfanumerico
      end
    end
    object dbgConsulta: TcxGrid
      Left = 1
      Top = 129
      Width = 983
      Height = 373
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object dbgConsultaDados: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = dbgConsultaDadosCustomDrawCell
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para adicionar um filtro'
        FilterRow.SeparatorColor = clActiveBorder
        FilterRow.Visible = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
        object dbgConsultaDadosMPX_DTALOG: TcxGridDBColumn
          Caption = 'Data Log.'
          DataBinding.FieldName = 'MPX_DTALOG'
          Options.AutoWidthSizable = False
          Width = 65
        end
        object dbgConsultaDadosMPX_HORLOG: TcxGridDBColumn
          Caption = 'Hora Log.'
          DataBinding.FieldName = 'MPX_HORLOG'
          Options.AutoWidthSizable = False
        end
        object dbgConsultaDadosMPX_DESCRI: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'MPX_DESCRI'
          Options.AutoWidthSizable = False
          Width = 182
        end
        object dbgConsultaDadosMPX_NOMFRM: TcxGridDBColumn
          Caption = 'Nome do Formul'#225'rio'
          DataBinding.FieldName = 'MPX_NOMFRM'
          Options.AutoWidthSizable = False
          Width = 145
        end
        object dbgConsultaDadosMPX_OPELOG: TcxGridDBColumn
          Caption = 'C'#243'd. Operador Log.'
          DataBinding.FieldName = 'MPX_OPELOG'
          Options.AutoWidthSizable = False
          Width = 101
        end
        object dbgConsultaDadosMPX_STATUS: TcxGridDBColumn
          Caption = 'Status'
          DataBinding.FieldName = 'STATUS'
          Options.AutoWidthSizable = False
          Width = 90
        end
        object dbgConsultaDadosMPX_DTACAD: TcxGridDBColumn
          Caption = 'Data Cadastro'
          DataBinding.FieldName = 'MPX_DTACAD'
          Options.AutoWidthSizable = False
          Width = 92
        end
        object dbgConsultaDadosMPX_HORCAD: TcxGridDBColumn
          Caption = 'Hora Cadastro'
          DataBinding.FieldName = 'MPX_HORCAD'
          Options.AutoWidthSizable = False
          Width = 89
        end
        object dbgConsultaDadosMPX_CODEMP: TcxGridDBColumn
          Caption = 'C'#243'd. Empresa'
          DataBinding.FieldName = 'MPX_CODEMP'
          Options.AutoWidthSizable = False
          Width = 78
        end
        object dbgConsultaDadosMPX_VALPIX: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'MPX_VALPIX'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taRightJustify
          Options.AutoWidthSizable = False
          Width = 81
        end
        object dbgConsultaDadosCTR_CODEMP: TcxGridDBColumn
          Caption = 'Gerado por'
          DataBinding.FieldName = 'MPX_CRIADO'
          Options.AutoWidthSizable = False
          Width = 93
        end
        object dbgConsultaDadosMPX_CHAPIX: TcxGridDBColumn
          Caption = 'Chave Pix'
          DataBinding.FieldName = 'MPX_CHAPIX'
          Options.AutoWidthSizable = False
          Width = 158
        end
        object dbgConsultaDadosBANCO: TcxGridDBColumn
          Caption = 'Banco'
          DataBinding.FieldName = 'BANCO'
          Options.AutoWidthSizable = False
          Width = 198
        end
        object dbgConsultaDadosPORTADOR: TcxGridDBColumn
          Caption = 'Portador'
          DataBinding.FieldName = 'PORTADOR'
          Options.AutoWidthSizable = False
          Width = 174
        end
        object dbgConsultaDadosMPX_TX_ID_: TcxGridDBColumn
          Caption = 'TxId'
          DataBinding.FieldName = 'MPX_TX_ID_'
          Visible = False
          GroupIndex = 0
          Options.AutoWidthSizable = False
          Width = 219
        end
        object dbgConsultaDadosMPX_QRCODE: TcxGridDBColumn
          Caption = 'C'#243'digo QRCode'
          DataBinding.FieldName = 'MPX_QRCODE'
          Options.AutoWidthSizable = False
          Width = 183
        end
        object dbgConsultaDadosMPX_SOLPAG: TcxGridDBColumn
          Caption = 'Solicit. Pagador'
          DataBinding.FieldName = 'MPX_SOLPAG'
          Options.AutoWidthSizable = False
          Width = 200
        end
        object dbgConsultaDadosMPX_DTAREC: TcxGridDBColumn
          Caption = 'Data Receb.'
          DataBinding.FieldName = 'MPX_DTAREC'
          PropertiesClassName = 'TcxDateEditProperties'
          Properties.DisplayFormat = 'dd/mm/yyy'
          Options.AutoWidthSizable = False
          Width = 90
        end
        object dbgConsultaDadosMPX_HORREC: TcxGridDBColumn
          Caption = 'Hora Receb.'
          DataBinding.FieldName = 'MPX_HORREC'
          Options.AutoWidthSizable = False
          Width = 74
        end
        object dbgConsultaDadosMPX_VALREC: TcxGridDBColumn
          Caption = 'Valor Receb.'
          DataBinding.FieldName = 'MPX_VALREC'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taRightJustify
          Options.AutoWidthSizable = False
          Width = 87
        end
        object dbgConsultaDadosMPX_OPEBAI: TcxGridDBColumn
          Caption = 'Ope. Baixa'
          DataBinding.FieldName = 'MPX_OPEBAI'
          Options.AutoWidthSizable = False
          Width = 85
        end
        object dbgConsultaDadosMPX_DOCPAG: TcxGridDBColumn
          Caption = 'Doc. Pagador'
          DataBinding.FieldName = 'MPX_DOCPAG'
          Options.Editing = False
          Width = 110
        end
        object dbgConsultaDadosMPX_NOMPAG: TcxGridDBColumn
          Caption = 'Nome Pagador'
          DataBinding.FieldName = 'MPX_NOMPAG'
          Width = 204
        end
        object dbgConsultaDadosPLANOCONTAS: TcxGridDBColumn
          Caption = 'Plano Contas da Baixa'
          DataBinding.FieldName = 'PLANOCONTAS'
          Options.AutoWidthSizable = False
          Width = 219
        end
        object dbgConsultaDadosMPX_INFPAG: TcxGridDBColumn
          Caption = 'Inf. Pagador'
          DataBinding.FieldName = 'MPX_INFPAG'
          Width = 208
        end
        object dbgConsultaDadosMPX_RESCAI: TcxGridDBColumn
          Caption = 'Origem Baixa doc.'
          DataBinding.FieldName = 'MPX_RESCAI'
          Options.AutoWidthSizable = False
          Width = 99
        end
        object dbgConsultaDadosMPX_DTABAI: TcxGridDBColumn
          Caption = 'Data da Baixa'
          DataBinding.FieldName = 'MPX_DTABAI'
          Options.AutoWidthSizable = False
          Width = 81
        end
        object dbgConsultaDadosMPX_SEQCON: TcxGridDBColumn
          Caption = 'Sequ'#234'ncial da Baixa'
          DataBinding.FieldName = 'MPX_SEQCON'
          Options.AutoWidthSizable = False
          Width = 112
        end
        object dbgConsultaDadosALTERACOES: TcxGridDBColumn
          DataBinding.FieldName = 'ALTERACOES'
          Visible = False
        end
        object dbgConsultaDadosMPX_NOMEXE: TcxGridDBColumn
          Caption = 'Nome EXE'
          DataBinding.FieldName = 'MPX_NOMEXE'
          Width = 130
        end
        object dbgConsultaDadosMPX_DTAEXE: TcxGridDBColumn
          Caption = 'Data EXE'
          DataBinding.FieldName = 'MPX_DTAEXE'
          Width = 65
        end
        object dbgConsultaDadosMPX_HOREXE: TcxGridDBColumn
          Caption = 'Hora EXE'
          DataBinding.FieldName = 'MPX_HOREXE'
        end
        object dbgConsultaDadosMPX_VEREXE: TcxGridDBColumn
          Caption = 'Vers'#227'o EXE'
          DataBinding.FieldName = 'MPX_VEREXE'
          Width = 95
        end
        object dbgConsultaDadosCLIENTE: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'CLIENTE'
          Width = 150
        end
        object dbgConsultaDadosDOCUMENTOS: TcxGridDBColumn
          Caption = 'Documentos'
          DataBinding.FieldName = 'DOCUMENTOS'
          Width = 300
        end
      end
      object dbgConsultaLevel1: TcxGridLevel
        GridView = dbgConsultaDados
      end
    end
    object pnlHeaderFiltros: TPanel
      Left = 1
      Top = 55
      Width = 983
      Height = 74
      Align = alTop
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 2
      DesignSize = (
        983
        74)
      object lblPeríodo: TLabel
        Left = 19
        Top = 22
        Width = 54
        Height = 14
        Alignment = taRightJustify
        Caption = 'Per'#237'odo de:'
      end
      object lblPeriodoA: TLabel
        Left = 170
        Top = 22
        Width = 7
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = #224
      end
      object lblStatus: TLabel
        Left = 289
        Top = 22
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Status:'
      end
      object lblEmpresaFiltro: TLabel
        Left = 26
        Top = 47
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresa:'
      end
      object grpLegendaCoresFiltro: TGroupBox
        Left = 838
        Top = 4
        Width = 140
        Height = 40
        Anchors = [akTop, akRight]
        Caption = 'Legenda de cores'
        TabOrder = 4
        StyleElements = [seFont, seBorder]
        object shpLegendaAlteradosFiltro: TShape
          Left = 16
          Top = 18
          Width = 25
          Height = 14
          Brush.Color = 8417535
        end
        object lblDescricaoAlteradosFiltro: TLabel
          Left = 47
          Top = 18
          Width = 87
          Height = 14
          Caption = 'Campos alterados'
        end
      end
      object edtDataFinal: TcxDateEdit
        Tag = 99
        Left = 180
        Top = 18
        Properties.ButtonGlyph.SourceDPI = 96
        Properties.ButtonGlyph.Data = {
          424D360400000000000036000000280000001000000010000000010020000000
          000000000000C40E0000C40E00000000000000000000000000020000000A0000
          0010000000110000001100000011000000120000001200000012000000120000
          00120000001300000013000000120000000C000000030000000A81594CC2B47C
          69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
          67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
          F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
          E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
          F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
          83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
          F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
          D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
          F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
          86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
          FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
          D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
          FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
          8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
          FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
          DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
          FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
          91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
          FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
          F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
          ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
          DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
          EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
          DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
          EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
          E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
          C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
          B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
          0006000000060000000600000007000000070000000700000007000000070000
          00070000000800000008000000070000000500000001}
        Properties.ClearKey = 46
        Properties.DateButtons = []
        Properties.MinDate = 2.000000000000000000
        Properties.ValidateOnEnter = False
        Properties.ValidationOptions = []
        StyleFocused.Color = clInfoBk
        TabOrder = 1
        Width = 90
      end
      object edtDataInicial: TcxDateEdit
        Tag = 99
        Left = 77
        Top = 18
        Properties.ButtonGlyph.SourceDPI = 96
        Properties.ButtonGlyph.Data = {
          424D360400000000000036000000280000001000000010000000010020000000
          000000000000C40E0000C40E00000000000000000000000000020000000A0000
          0010000000110000001100000011000000120000001200000012000000120000
          00120000001300000013000000120000000C000000030000000A81594CC2B47C
          69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
          67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
          F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
          E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
          F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
          83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
          F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
          D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
          F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
          86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
          FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
          D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
          FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
          8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
          FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
          DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
          FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
          91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
          FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
          F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
          ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
          DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
          EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
          DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
          EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
          E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
          C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
          B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
          0006000000060000000600000007000000070000000700000007000000070000
          00070000000800000008000000070000000500000001}
        Properties.ClearKey = 46
        Properties.DateButtons = []
        Properties.MinDate = 2.000000000000000000
        Properties.ValidateOnEnter = False
        Properties.ValidationOptions = []
        StyleFocused.Color = clInfoBk
        TabOrder = 0
        Width = 90
      end
      object cmbStatus: TComboBoxFocus
        Left = 329
        Top = 19
        Width = 194
        Height = 22
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 2
        Text = 'Devolvidos'
        Items.Strings = (
          'Devolvidos'
          'Expirados'
          'Removidos'
          'Todos')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object btnCarrCartoes: TBitBtnLocked
        Left = 570
        Top = 44
        Width = 127
        Height = 22
        Align = alCustom
        Caption = '&Carregar Registros'
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
        TabOrder = 5
        OnClick = btnCarrCartoesClick
      end
      object edtCodigoEmpresaFiltro: TEditFocus
        Tag = 99
        Left = 77
        Top = 44
        Width = 67
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 3
        OnExit = edtCodigoEmpresaFiltroExit
        OnKeyPress = edtCodigoEmpresaFiltroKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtNomeEmpresaFiltro: TEditFocus
        Left = 145
        Top = 44
        Width = 378
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 6
        NormalColor = 16768952
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
    Left = 792
    Top = 424
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 800
    Top = 416
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 808
    Top = 448
  end
end
