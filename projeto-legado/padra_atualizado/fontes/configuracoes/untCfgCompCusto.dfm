inherited frmCfgCompCusto: TfrmCfgCompCusto
  Width = 800
  Height = 600
  Caption = 'Composi'#231#227'o do Pre'#231'o de Custo para Relat'#243'rios'
  OnKeyPress = FormKeyPress
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 529
    Width = 794
    ExplicitTop = 529
    ExplicitWidth = 794
    inherited FlwBotoes: TFlowPanel
      Width = 713
      ExplicitWidth = 790
      inherited btnConfirma: TBitBtnLocked
        Width = 121
        ModalResult = 0
        ExplicitWidth = 121
      end
      object btnRemCom: TBitBtnLocked
        Left = 121
        Top = 0
        Width = 136
        Height = 22
        Caption = 'Remover Composi'#231#227'o'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333000033338833333333333333333F333333333333
          0000333911833333983333333388F333333F3333000033391118333911833333
          38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
          911118111118333338F3338F833338F3000033333911111111833333338F3338
          3333F8330000333333911111183333333338F333333F83330000333333311111
          8333333333338F3333383333000033333339111183333333333338F333833333
          00003333339111118333333333333833338F3333000033333911181118333333
          33338333338F333300003333911183911183333333383338F338F33300003333
          9118333911183333338F33838F338F33000033333913333391113333338FF833
          38F338F300003333333333333919333333388333338FFF830000333333333333
          3333333333333333333888330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnRemComClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 715
      Top = 2
      Align = alRight
      ExplicitLeft = 714
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 794
    Height = 529
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = ' '
    Color = 16770261
    TabOrder = 2
    ExplicitHeight = 269
    object Label12: TLabel
      Left = 25
      Top = 20
      Width = 52
      Height = 14
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Descri'#231#227'o:'
      ParentBiDiMode = False
    end
    object Label1: TLabel
      Left = 15
      Top = 48
      Width = 62
      Height = 14
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Composi'#231#227'o:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
    end
    object Label37: TLabel
      Left = 429
      Top = 20
      Width = 109
      Height = 14
      Alignment = taRightJustify
      Caption = 'Principal p/ Relat'#243'rios?'
    end
    object ColorLabel1: TColorLabel
      Left = 584
      Top = 20
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object Label2: TLabel
      Left = 97
      Top = 243
      Width = 71
      Height = 14
      Alignment = taRightJustify
      BiDiMode = bdRightToLeft
      Caption = 'Pre'#231'o Principal'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
    end
    object shp3: TShape
      Left = 78
      Top = 243
      Width = 19
      Height = 13
      Brush.Color = clRed
      Shape = stSquare
    end
    object Shape1: TShape
      Left = 190
      Top = 243
      Width = 19
      Height = 13
      Brush.Color = clGreen
      Shape = stSquare
    end
    object Label4: TLabel
      Left = 209
      Top = 243
      Width = 128
      Height = 14
      Alignment = taRightJustify
      BiDiMode = bdRightToLeft
      Caption = 'Impostos e Outros Valores'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
    end
    object edtDescri: TEditFocus
      Tag = 99
      Left = 78
      Top = 17
      Width = 338
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 50
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 50
      TipoTexto = ttAlfanumerico
    end
    object btnAdicionarCtt: TBitBtnLocked
      Left = 605
      Top = 241
      Width = 83
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
      OnClick = btnAdicionarCttClick
    end
    object chklstCompos: TCheckListBox
      Left = 78
      Top = 48
      Width = 610
      Height = 187
      OnClickCheck = chklstComposClickCheck
      Columns = 1
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ItemHeight = 14
      ParentFont = False
      Style = lbOwnerDrawFixed
      TabOrder = 2
      OnDrawItem = chklstComposDrawItem
    end
    object edtSugeri: TEditFocus
      Tag = 99
      Left = 544
      Top = 17
      Width = 35
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      ParentFont = False
      TabOrder = 1
      OnKeyPress = edtSugeriKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfanumerico
    end
    object Panel1: TPanel
      Left = 2
      Top = 497
      Width = 790
      Height = 30
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 4
      object Label3: TLabel
        Left = 0
        Top = 0
        Width = 790
        Height = 28
        Align = alTop
        Caption = 
          #201' poss'#237'vel editar as f'#243'rmulas diretamente na grid. Dentre as op'#231 +
          #245'es s'#227'o poss'#237'veis trocar\acrescentar sinais matem'#225'ticos (+, -, /' +
          ', *) e par'#234'nteses. Alterar vari'#225'veis somente pela escolha direto' +
          ' na composi'#231#227'o.'
        WordWrap = True
        ExplicitWidth = 785
      end
    end
  end
  object cxgComCus: TcxGrid [3]
    Left = 2
    Top = 269
    Width = 785
    Height = 219
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgComCusDBTableView1: TcxGridDBTableView
      OnKeyDown = cxgComCusDBTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = cxgComCusDBTableView1CellDblClick
      OnCustomDrawCell = cxgComCusDBTableView1CustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.CellAutoHeight = True
      OptionsView.GroupByBox = False
      object cxgComCusSUGERI: TcxGridDBColumn
        Caption = 'Padr'#227'o'
        DataBinding.FieldName = 'COM_SUGERI'
        OnGetDisplayText = cxgComCusSUGERIGetDisplayText
        Options.Editing = False
        Width = 45
      end
      object cxgComCusDESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'COM_DESCRI'
        Options.Editing = False
        Width = 310
      end
      object cxgComCusFORMUL: TcxGridDBColumn
        Caption = 'Layout da Composi'#231#227'o'
        DataBinding.FieldName = 'COM_LAYOUT'
        Width = 420
      end
    end
    object cxgComCusLevel1: TcxGridLevel
      GridView = cxgComCusDBTableView1
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 794
    ExplicitTop = 555
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 40
    Top = 296
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 8
    Top = 296
  end
end
