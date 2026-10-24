inherited frmCadFatReg: TfrmCadFatReg
  Width = 707
  Height = 734
  Caption = 'Fator Regional'
  ExplicitWidth = 707
  ExplicitHeight = 734
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 664
    Width = 701
    Height = 25
    ExplicitTop = 664
    ExplicitWidth = 703
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 620
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 622
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Height = 21
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Height = 21
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Height = 21
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Height = 21
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Height = 21
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Height = 21
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 622
      Height = 21
      Align = alRight
      ExplicitLeft = 624
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Width = 701
    Height = 664
    ExplicitWidth = 703
    ExplicitHeight = 664
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 695
      ExplicitHeight = 632
    end
  end
  inherited pnlStatus: TPanel
    Top = 689
    Width = 701
    ExplicitTop = 689
    ExplicitWidth = 703
    inherited pnlNomeForm: TPanel
      Left = 354
      ExplicitLeft = 356
    end
    inherited pnlInfo: TPanel
      Width = 354
      ExplicitWidth = 356
    end
  end
  object pnlPrincipal: TPanel [4]
    Left = 0
    Top = 0
    Width = 701
    Height = 664
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    ExplicitWidth = 703
    object Label1: TLabel
      Left = 64
      Top = 20
      Width = 36
      Height = 14
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 42
      Top = 45
      Width = 58
      Height = 14
      Caption = 'IVA Original:'
    end
    object Label3: TLabel
      Left = 181
      Top = 20
      Width = 121
      Height = 14
      Caption = 'Descri'#231#227'o da Resolu'#231#227'o:'
    end
    object Label4: TLabel
      Left = 174
      Top = 45
      Width = 10
      Height = 14
      Caption = '%'
    end
    object Label5: TLabel
      Left = 361
      Top = 45
      Width = 160
      Height = 14
      Caption = 'C'#243'digo de Entrada no Amazonas:'
    end
    object Label6: TLabel
      Left = 8
      Top = 68
      Width = 93
      Height = 14
      Caption = 'Situa'#231#227'o Tribut'#225'ria:'
    end
    object dbeCodFatReg: TDBEditFocus
      Tag = 99
      Left = 104
      Top = 17
      Width = 68
      Height = 22
      DataField = 'REG_CODIGO'
      DataSource = dtsTabela
      MaxLength = 5
      TabOrder = 0
      OnExit = dbeCodFatRegExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeDesFatReg: TDBEditFocus
      Tag = 99
      Left = 305
      Top = 17
      Width = 383
      Height = 22
      CharCase = ecUpperCase
      DataField = 'REG_DESCRI'
      DataSource = dtsTabela
      MaxLength = 80
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeIvaFatReg: TDBEditFocus
      Tag = 99
      Left = 104
      Top = 41
      Width = 68
      Height = 22
      DataField = 'REG_IVAORI'
      DataSource = dtsTabela
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object grbNCM: TGroupBox
      Left = 14
      Top = 94
      Width = 665
      Height = 212
      Caption = 'Cadastro de NCM'
      TabOrder = 3
      object pnlNCM: TPanel
        Left = 2
        Top = 169
        Width = 661
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object btnExcluiNCM: TBitBtnLocked
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 122
          Height = 35
          Align = alLeft
          Caption = 'Excluir NCM'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
            6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
            00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
            00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
            DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
            006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
            16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
            20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
            6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
            00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
            00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
            E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 0
          TabStop = False
          OnClick = btnExcluiNCMClick
        end
      end
      object cxgNCM: TcxGrid
        AlignWithMargins = True
        Left = 5
        Top = 19
        Width = 655
        Height = 147
        Align = alClient
        TabOrder = 1
        TabStop = False
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgNCMView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NewItemRow.InfoText = 'Clique aqui para adicionar um NCM'
          NewItemRow.Visible = True
          OptionsData.Deleting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.GroupByBox = False
          object cxgFatRegCODNCM: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'FRE_CODNCM'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ValidateOnEnter = True
            SortIndex = 0
            SortOrder = soAscending
            Width = 150
          end
          object cxgFatRegDESNCM: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'FRE_DESNCM'
            Options.Editing = False
            Width = 460
          end
        end
        object cxgNCMLevel: TcxGridLevel
          GridView = cxgNCMView
        end
      end
    end
    object grbFatReg: TGroupBox
      Left = 16
      Top = 309
      Width = 665
      Height = 346
      Caption = 'C'#225'lculo do Fator Regional'
      TabOrder = 4
      object pnlFatReg: TPanel
        Left = 2
        Top = 303
        Width = 661
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object btnCalculaFatReg: TBitBtnLocked
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 158
          Height = 35
          Align = alLeft
          Caption = 'Calcular Fator Regional'
          Glyph.Data = {
            06030000424D060300000000000036000000280000000F0000000F0000000100
            180000000000D0020000C40E0000C40E00000000000000000000FFFFFFFFFFFF
            9E9E9EADADADAFAFAFABAAABACAFABB2AEAEA5AAACB2AEAFB2AFB0A8ACABA4A6
            A5FFFFFFFFFFFF000000FFFFFFF2F2F2A0A0A0BFBFBFAFAFAFD2CFD0B1B6B5B0
            ADAFD8D8D5C5AA9ECCA294E3D1CBA3A1A2FFFEFEFFFFFF000000FFFFFFF3F3F3
            A2A2A2A4A4A4939393BFBEBC989B9E949298CFCAC3B6866EBB8062D3BAADA4A4
            A6FFFEFFFFFFFF000000FFFFFFF4F4F49F9F9FC4C4C4B5B5B5D2D2D1BDBBBDB7
            B4B9DEDCD4BC8871BB8565D1BEACA2A7A5FEFEFFFFFFFF000000FFFFFFF4F4F4
            A4A4A49B9B9B8A8A89B6B7B79791918B898AC3C5BDB5826FBA7A5DD6BAAAA6A5
            A1FFFEFFFFFFFF000000FFFFFFF4F4F49E9E9ECFCFCFC2C2C2DAD6D8CDCAC4B9
            C3C6E0DED699BFF582B9F7C4DDF1A49FA3FDFFFFFFFFFF000000FFFFFFF4F4F4
            A3A3A39A9A9A8A8A8AB6B9B6909195918787B8BFC70974ED0064FF70AEF1ACA3
            A5FFFFFEFFFFFF000000FFFFFFF4F4F4A0A0A0CCCBCBBDBEBED4D6D9CCC6BFBC
            BEBED5DBDFA6BEDA9BB7D6CDDBE5AAA1A0FFFFFFFFFFFF000000FFFFFFF4F4F4
            A3A2A39A999A888788B6B4BD8E9193818986BFC0BB99908E8C8885B5BDC0A4A1
            A8FEFFFFFFFFFF000000FFFFFFF4F4F49F9F9FE2E2E3D5D4D6E6E4E1D6D5D9D9
            D2D5E4E4E8D4D4D3D6D1CFE8ECEBA8A09FFFFFFFFFFFFF000000FFFFFFF5F5F6
            9A9E974C741B598E2B5E8E2965952F6B9937709C4378A15179A85960813DABAA
            AAFFFEFFFFFFFF000000FFFFFFF6F5F7949891648F298ACA3983CB498BD44E92
            DA579ADF61A4E971BFFA89799F56A4A3AFFFFFFFFFFFFF000000FFFFFFF4F4F5
            9FA29B5A7537567D23587B20577C1E577C1D577B1D557A1D4C781863803CAEAF
            A8FFFEFFFFFFFF000000FFFFFFFBFBFB757775B6B9B5AFB2AFB0B0B5B0B1B3B0
            B1B4B0B2B1B0B2B2AFAEB5B8B7B3837F7FFFFFFFFFFFFF000000FFFFFFFFFFFF
            FFFFFFFBFAFBFBFAFCFBFBFBFBFAFBFBFAFBFBFBFBFBFBFBFBFAFBFAF9FBFFFF
            FFFFFFFFFFFFFF000000}
          TabOrder = 0
          TabStop = False
          OnClick = btnCalculaFatRegClick
        end
      end
      object cxgFatReg: TcxGrid
        AlignWithMargins = True
        Left = 5
        Top = 19
        Width = 655
        Height = 281
        Align = alClient
        TabOrder = 1
        TabStop = False
        LookAndFeel.ScrollbarMode = sbmClassic
        ExplicitLeft = 8
        ExplicitTop = 16
        object cxgFatRegView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.GroupByBox = False
          object cxgCalcESTADO: TcxGridDBColumn
            Caption = 'UF'
            DataBinding.FieldName = 'CFR_ESTADO'
            Options.Editing = False
            Width = 65
          end
          object cxgCalcALQINT: TcxGridDBColumn
            Caption = '% Alq. Interna'
            DataBinding.FieldName = 'CFR_ALQINT'
            Width = 150
          end
          object cxgCalcALQEST: TcxGridDBColumn
            Caption = '% Alq. Interestadual'
            DataBinding.FieldName = 'CFR_ALQEST'
            Width = 150
          end
          object cxgCalcFATREG: TcxGridDBColumn
            Caption = '% Fator Regional'
            DataBinding.FieldName = 'CFR_FATREG'
            Options.Editing = False
            Width = 150
          end
        end
        object cxgfatRegLevel: TcxGridLevel
          GridView = cxgFatRegView
        end
      end
    end
    object dbeEntAma: TDBEditFocus
      Tag = 99
      Left = 524
      Top = 41
      Width = 47
      Height = 22
      CharCase = ecUpperCase
      DataField = 'REG_ENTAMA'
      DataSource = dtsTabela
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodTri: TDBEditFocus
      Tag = 99
      Left = 104
      Top = 64
      Width = 68
      Height = 22
      DataField = 'REG_CODTRI'
      DataSource = dtsTabela
      TabOrder = 6
      OnKeyPress = dbeCodTriKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object edtDesTri: TEditFocus
      Left = 173
      Top = 64
      Width = 398
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 896
    Top = 488
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 864
    Top = 488
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 776
    Top = 528
  end
  object dtsTabela: TDataSource
    Left = 876
    Top = 615
  end
end
