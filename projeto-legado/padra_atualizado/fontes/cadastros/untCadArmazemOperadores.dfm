inherited frmCadArmazemOperadores: TfrmCadArmazemOperadores
  Width = 830
  Height = 757
  Caption = 'Controle de armaz'#233'm por operadores'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitTop = -84
  ExplicitWidth = 830
  ExplicitHeight = 757
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 684
    Width = 824
    ExplicitTop = 684
    ExplicitWidth = 824
    inherited FlwBotoes: TFlowPanel
      Width = 820
      ExplicitWidth = 820
    end
    inherited btnSair: TBitBtnLocked
      Left = 743
      ExplicitLeft = 743
    end
  end
  inherited pnlStatus: TPanel
    Top = 712
    Width = 824
    ExplicitTop = 712
    ExplicitWidth = 824
    inherited pnlNomeForm: TPanel
      Left = 653
      ExplicitLeft = 653
    end
    inherited pnlInfo: TPanel
      Width = 653
      ExplicitWidth = 653
    end
  end
  object pnlInformacoes: TPanel [2]
    Left = 0
    Top = 0
    Width = 824
    Height = 684
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object gpbInfoAmz: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 331
      Width = 818
      Height = 350
      Align = alBottom
      Caption = 'Informa'#231#245'es do armaz'#233'm'
      TabOrder = 0
      object pnlInfoAmz: TPanel
        Left = 2
        Top = 16
        Width = 814
        Height = 73
        Align = alTop
        TabOrder = 0
        Visible = False
        object lblEmpAmz: TLabel
          Left = 10
          Top = 15
          Width = 108
          Height = 14
          Alignment = taRightJustify
          Caption = 'Empresa do Armazem:'
        end
        object lblAmz: TLabel
          Left = 69
          Top = 39
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Armazem:'
        end
        object edtCodAmz: TEditFocus
          Tag = 99
          Left = 124
          Top = 35
          Width = 44
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 1
          OnKeyPress = edtCodAmzKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object edtCodEmp: TEditFocus
          Tag = 99
          Left = 124
          Top = 11
          Width = 44
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 0
          OnKeyPress = edtCodEmpKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object edtNomEmp: TEditFocus
          Left = 169
          Top = 11
          Width = 433
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtDesAmz: TEditFocus
          Left = 169
          Top = 35
          Width = 433
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object pnlOperadores: TPanel
        Left = 2
        Top = 89
        Width = 814
        Height = 259
        Align = alClient
        TabOrder = 1
        object pnlBotoesOpe: TPanel
          Left = 1
          Top = 232
          Width = 812
          Height = 26
          Align = alBottom
          TabOrder = 0
          object btnCancela: TBitBtnLocked
            AlignWithMargins = True
            Left = 716
            Top = 2
            Width = 90
            Height = 22
            Margins.Left = 1
            Margins.Top = 1
            Margins.Right = 5
            Margins.Bottom = 1
            Align = alRight
            Caption = '&Cancelar'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
              015603015603FF00FF0000820000820000820000820000820000820000820000
              820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
              27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
              30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
              FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
              0082000082000082000082000082000082000082000082000082FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
              00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
              0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
              50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
              5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
              8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            TabOrder = 0
            OnClick = btnCancelaClick
          end
          object btnGravar: TBitBtnLocked
            AlignWithMargins = True
            Left = 4
            Top = 2
            Width = 141
            Height = 22
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            Align = alLeft
            Caption = '[ F10 ] - Confirmar'
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
          object btnMarDes: TBitBtnLocked
            AlignWithMargins = True
            Left = 196
            Top = 2
            Width = 145
            Height = 22
            Margins.Left = 50
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            Align = alLeft
            Caption = '[SPACE] Marcar/Desmarca'
            TabOrder = 2
            OnClick = btnMarDesClick
            ExplicitLeft = 150
          end
          object btnMarTodos: TBitBtnLocked
            AlignWithMargins = True
            Left = 343
            Top = 2
            Width = 134
            Height = 22
            Margins.Left = 1
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            Align = alLeft
            Caption = '[F2] Marcar todos'
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
            OnClick = btnMarTodosClick
            ExplicitLeft = 297
          end
          object btnDesmarTodos: TBitBtnLocked
            AlignWithMargins = True
            Left = 479
            Top = 2
            Width = 134
            Height = 22
            Margins.Left = 1
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            Align = alLeft
            Caption = '[F3] Desmarcar todos'
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
            OnClick = btnDesmarTodosClick
            ExplicitLeft = 433
          end
        end
        object cxGridOperadores: TcxGrid
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 806
          Height = 225
          Align = alClient
          TabOrder = 1
          object gridOperadoresView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dtsOperadores
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.Visible = True
            OptionsView.NoDataToDisplayInfoText = 'Sem operadores'
            OptionsView.GroupByBox = False
            object gridOperadoresViewCODOPE: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'OPE_CODOPE'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              SortIndex = 0
              SortOrder = soAscending
              Width = 83
            end
            object gridOperadoresViewNOMOPE: TcxGridDBColumn
              Caption = 'Nome'
              DataBinding.FieldName = 'OPE_NOMOPE'
              Options.Editing = False
              Width = 353
            end
            object cxGridDBColumn3: TcxGridDBColumn
              DataBinding.FieldName = 'AUTOINCREM'
              Visible = False
            end
            object gridOperadoresViewACESSO: TcxGridDBColumn
              Caption = 'Acesso'
              DataBinding.FieldName = 'ACESSO'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Width = 65
            end
          end
          object cxGridLevel1: TcxGridLevel
            GridView = gridOperadoresView
          end
        end
      end
    end
    object gpbOperadores: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 818
      Height = 322
      Align = alClient
      Caption = 'Armazens Configurados'
      TabOrder = 1
      object cxGridArmazens: TcxGrid
        AlignWithMargins = True
        Left = 5
        Top = 19
        Width = 808
        Height = 272
        Align = alClient
        TabOrder = 0
        object gridArmazensView: TcxGridDBTableView
          OnDblClick = gridArmazensViewDblClick
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsArmazens
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.Visible = True
          OptionsData.Deleting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = 'Sem armaz'#233'ns'
          OptionsView.GroupByBox = False
          object gridArmazensViewCODAMZ: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'AMZ_CODAMZ'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Caption = 'Editar...'
                Default = True
                Kind = bkEllipsis
              end>
            HeaderAlignmentHorz = taCenter
            Width = 83
          end
          object gridArmazensViewDESAMZ: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'AMZ_DESCRI'
            Width = 599
          end
          object cxGridOperadoresAUTOINCREM: TcxGridDBColumn
            DataBinding.FieldName = 'AUTOINCREM'
            Visible = False
          end
          object gridArmazensViewCODEMP: TcxGridDBColumn
            Caption = 'Empresa'
            DataBinding.FieldName = 'AMZ_CODEMP'
            MinWidth = 64
          end
        end
        object cxGridArmazensLevel1: TcxGridLevel
          GridView = gridArmazensView
        end
      end
      object pnlRodapeOperadores: TPanel
        Left = 2
        Top = 294
        Width = 814
        Height = 26
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object lblLegenda: TLabel
          Left = 0
          Top = 0
          Width = 814
          Height = 26
          Align = alClient
          Alignment = taCenter
          Caption = 
            '[INSERT] Para Incluir Nova Rela'#231#227'o    [DELETE] Para Excluir    [' +
            'Duplo Clique] Para Alterar'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 630
          ExplicitHeight = 15
        end
      end
    end
  end
  object dtsArmazens: TDataSource
    Left = 456
    Top = 152
  end
  object dtsOperadores: TDataSource
    Left = 392
    Top = 232
  end
end
