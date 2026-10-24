inherited frmCadFaixaDescTabPrecoLinhaGrupo: TfrmCadFaixaDescTabPrecoLinhaGrupo
  Left = 0
  Top = 0
  Width = 680
  Height = 696
  Caption = 'Faixas de Desconto por Tabela de Pre'#231'o e Linha\Grupo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OldCreateOrder = False
  ExplicitWidth = 680
  ExplicitHeight = 696
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Top = 626
    Width = 674
    Height = 25
    TabOrder = 4
    ExplicitTop = 626
    ExplicitWidth = 674
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 593
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 670
      ExplicitHeight = 22
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
      Left = 595
      Height = 21
      Align = alRight
      ExplicitLeft = 593
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Top = 624
    Width = 674
    Height = 2
    ActivePage = nil
    Align = alBottom
    Style = tsButtons
    TabOrder = 6
    ExplicitTop = 623
    ExplicitWidth = 674
    ExplicitHeight = 2
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 666
      ExplicitHeight = 227
    end
  end
  inherited pnlStatus: TPanel
    Top = 651
    Width = 674
    TabOrder = 5
    ExplicitTop = 651
    ExplicitWidth = 674
    inherited pnlNomeForm: TPanel
      Left = 327
      ExplicitLeft = 327
    end
    inherited pnlInfo: TPanel
      Width = 327
      ExplicitWidth = 327
    end
  end
  object pnlGrid: TPanel [4]
    Left = 0
    Top = 97
    Width = 674
    Height = 184
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label12: TLabel
      Left = 4
      Top = 159
      Width = 225
      Height = 13
      Caption = 'Pressione [DEL] para remover registros do Grid'
    end
    object dbgDados: TDBGridCitel
      Left = 1
      Top = 1
      Width = 672
      Height = 152
      Align = alTop
      DataSource = dtsDados
      Options = [dgTitles, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDblClick = dbgDadosDblClick
      OnKeyDown = dbgDadosKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'COM_DESINI'
          Title.Alignment = taRightJustify
          Title.Caption = '% Desc. Ini.'
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COM_DESFIM'
          Title.Alignment = taRightJustify
          Title.Caption = '% Desc. Fin.'
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COM_COMAVI'
          Title.Alignment = taRightJustify
          Title.Caption = '% Com. a Vista'
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COM_COMAPR'
          Title.Alignment = taRightJustify
          Title.Caption = '%Com. a Prazo'
          Width = 110
          Visible = True
        end>
    end
  end
  object Panel1: TPanel [5]
    Left = 0
    Top = 41
    Width = 674
    Height = 56
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    object Label2: TLabel
      Left = 6
      Top = 8
      Width = 75
      Height = 13
      Caption = 'Desconto Inicial'
    end
    object Label3: TLabel
      Left = 144
      Top = 6
      Width = 70
      Height = 13
      Caption = 'Desconto Final'
    end
    object Label4: TLabel
      Left = 421
      Top = 6
      Width = 98
      Height = 13
      Caption = '% Comiss'#227'o a Prazo'
    end
    object Label8: TLabel
      Left = 282
      Top = 6
      Width = 94
      Height = 13
      Caption = '% Comiss'#227'o a Vista'
    end
    object edtDesIni: TEditFocus
      Tag = 99
      Left = 6
      Top = 22
      Width = 135
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 0
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDesFin: TEditFocus
      Tag = 99
      Left = 144
      Top = 22
      Width = 135
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 1
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtComPra: TEditFocus
      Tag = 99
      Left = 421
      Top = 22
      Width = 135
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 3
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object btnAdicionar: TBitBtnLocked
      Left = 562
      Top = 22
      Width = 91
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
      TabOrder = 4
      OnClick = btnAdicionarClick
    end
    object edtComVis: TEditFocus
      Tag = 99
      Left = 282
      Top = 22
      Width = 135
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 2
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
  object pnlLinhaGrupo: TPanel [6]
    Left = 0
    Top = 281
    Width = 674
    Height = 338
    Align = alTop
    BevelOuter = bvSpace
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object pnlLinhaGrupoFiltro: TPanel
      Left = 1
      Top = 1
      Width = 672
      Height = 32
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object Label5: TLabel
        Left = 8
        Top = 9
        Width = 62
        Height = 13
        Alignment = taRightJustify
        Caption = 'Linha/Grupo:'
      end
      object edtDescLinhaGrupo: TEditFocus
        Left = 154
        Top = 6
        Width = 415
        Height = 21
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
      object btnAddLinhaGrupo: TBitBtnLocked
        Left = 575
        Top = 4
        Width = 77
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
        TabOrder = 1
        OnClick = btnAddLinhaGrupoClick
      end
      object edtLinhaGrupo: TEditFocus
        Tag = 99
        Left = 73
        Top = 6
        Width = 75
        Height = 21
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 0
        OnKeyPress = edtLinhaGrupoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlLinhaGrupoGrid: TPanel
      Left = 1
      Top = 33
      Width = 672
      Height = 313
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object Label6: TLabel
        Left = 5
        Top = 287
        Width = 225
        Height = 13
        Caption = 'Pressione [DEL] para remover registros do Grid'
      end
      object grdLinhaGrupo: TcxGridCitel
        Left = 0
        Top = 0
        Width = 672
        Height = 281
        Align = alTop
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdLinhaGrupoDBTable: TcxGridDBTableViewCitel
          OnKeyDown = grdLinhaGrupoDBTableKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsLinhaGrupo
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.ShowColumnFilterButtons = sfbAlways
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object grdLinhaGrupoDBTableViewCitelFTG_CODGRU: TcxGridDBColumn
            Caption = 'Linha\Grupo'
            DataBinding.FieldName = 'COM_CODGRU'
            Width = 83
          end
          object grdLinhaGrupoDBTableViewCitelGRU_DESGRU: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'COM_NOMGRU'
            Width = 284
          end
        end
        object grdLinhaGrupoLevel1: TcxGridLevel
          GridView = grdLinhaGrupoDBTable
        end
      end
    end
  end
  object pnlTopo: TPanel [7]
    Left = 0
    Top = 0
    Width = 674
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 9
      Top = 12
      Width = 37
      Height = 13
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label7: TLabel
      Left = 116
      Top = 12
      Width = 50
      Height = 13
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label9: TLabel
      Left = 409
      Top = 12
      Width = 81
      Height = 13
      Caption = 'Tabela de Pre'#231'o:'
    end
    object clbPrcVenda: TColorLabel
      Left = 535
      Top = 12
      Width = 118
      Height = 13
      Caption = 'Pre'#231'o de Venda (1) a (7)'
      CorDestaque = clRed
    end
    object dbeCodTab: TDBEditFocus
      Tag = 99
      Left = 48
      Top = 9
      Width = 62
      Height = 21
      CharCase = ecUpperCase
      DataField = 'COM_CODTAB'
      DataSource = dtsComFat
      TabOrder = 0
      OnExit = dbeCodTabExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDescricao: TDBEditFocus
      Tag = 99
      Left = 169
      Top = 9
      Width = 234
      Height = 21
      CharCase = ecUpperCase
      DataField = 'COM_DESCRI'
      DataSource = dtsComFat
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTabPre: TDBEditFocus
      Tag = 99
      Left = 492
      Top = 9
      Width = 37
      Height = 21
      CharCase = ecUpperCase
      DataField = 'COM_TABPRE'
      DataSource = dtsComFat
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 592
    Top = 472
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 560
    Top = 472
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 528
    Top = 472
  end
  object dtsComFat: TDataSource
    Left = 328
    Top = 144
  end
  object dtsDados: TDataSource
    Left = 409
    Top = 152
  end
  object dtsLinhaGrupo: TDataSource
    Left = 345
    Top = 432
  end
end
