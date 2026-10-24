inherited frmCadReformaTributariaCreditoDebito: TfrmCadReformaTributariaCreditoDebito
  Width = 1024
  Height = 768
  BorderStyle = bsDialog
  Caption = 'Reforma Tribut'#225'ria Cr'#233'dito / D'#233'bito'
  Position = poDesktopCenter
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 695
    Width = 1018
    ExplicitTop = 695
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
      object btnAlterar: TBitBtnLocked
        AlignWithMargins = True
        Left = 1
        Top = 1
        Width = 100
        Height = 22
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = '[ F2 ] Alterar'
        TabOrder = 0
        OnClick = btnAlterarClick
      end
      object btnCancelar: TBitBtnLocked
        AlignWithMargins = True
        Left = 103
        Top = 1
        Width = 100
        Height = 22
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = '[ F3 ] Cancelar'
        TabOrder = 1
        OnClick = btnCancelarClick
      end
      object btnConfirma: TBitBtnLocked
        AlignWithMargins = True
        Left = 205
        Top = 1
        Width = 100
        Height = 22
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = '[ F10 ] Confirmar'
        TabOrder = 2
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 937
      ExplicitLeft = 937
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1018
    ExplicitTop = 723
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
  object pnlPrincipal: TPanel [2]
    Left = 0
    Top = 0
    Width = 1018
    Height = 695
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object pnlDebito: TPanel
      Left = 0
      Top = 340
      Width = 1018
      Height = 140
      Align = alTop
      TabOrder = 1
      object Label17: TLabel
        Left = 18
        Top = 86
        Width = 117
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'd.Classifica'#231#227'o Trib.:'
        Layout = tlBottom
      end
      object Label1: TLabel
        Left = 18
        Top = 61
        Width = 117
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'd.Situa'#231#227'o Trib.:'
        Layout = tlBottom
      end
      object Label2: TLabel
        Left = 18
        Top = 36
        Width = 117
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'd.Tipo D'#233'bito :'
        Layout = tlBottom
      end
      object Label7: TLabel
        Left = 3
        Top = 111
        Width = 132
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Usa Chave Referenciada:'
        Layout = tlBottom
      end
      object ColorLabel1: TColorLabel
        Left = 221
        Top = 111
        Width = 61
        Height = 14
        Caption = '(S)im / (N)'#227'o'
        CorDestaque = clRed
      end
      object Label10: TLabel
        Left = 314
        Top = 111
        Width = 79
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Usa M'#234's/Ano:'
        Layout = tlBottom
      end
      object ColorLabel4: TColorLabel
        Left = 479
        Top = 111
        Width = 61
        Height = 14
        Caption = '(S)im / (N)'#227'o'
        CorDestaque = clRed
      end
      object Label11: TLabel
        Left = 570
        Top = 111
        Width = 79
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Usa CBS e IBS:'
        Layout = tlBottom
      end
      object ColorLabel5: TColorLabel
        Left = 735
        Top = 111
        Width = 61
        Height = 14
        Caption = '(S)im / (N)'#227'o'
        CorDestaque = clRed
      end
      object Panel1: TPanel
        Left = 1
        Top = 1
        Width = 1016
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        BevelWidth = 2
        Caption = 'D'#233'bito'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 8
      end
      object dbeClaFisDebitoDescr: TEditFocus
        Left = 221
        Top = 83
        Width = 791
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 9
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object dbeCstDebitoDescr: TEditFocus
        Left = 221
        Top = 58
        Width = 791
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 10
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object dbeTipoDebitoDescr: TEditFocus
        Left = 221
        Top = 33
        Width = 791
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 11
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object btnConfirmaDebito: TBitBtnLocked
        Left = 829
        Top = 108
        Width = 90
        Height = 22
        Caption = 'C&onfirma'
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
        TabOrder = 6
        OnClick = btnConfirmaDebitoClick
      end
      object btnCancelaDebito: TBitBtnLocked
        Left = 922
        Top = 108
        Width = 90
        Height = 22
        Caption = 'Ca&ncelar'
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
        TabOrder = 7
        OnClick = btnCancelaDebitoClick
      end
      object dbeTipoDebito: TEditFocus
        Tag = 99
        Left = 138
        Top = 33
        Width = 80
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 2
        TabOrder = 0
        OnKeyPress = dbeTipoDebitoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 2
        TipoTexto = ttNumerico
      end
      object dbeCstDebito: TEditFocus
        Tag = 99
        Left = 138
        Top = 58
        Width = 80
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 1
        OnKeyPress = dbeCstDebitoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object dbeClaFisDebito: TEditFocus
        Tag = 99
        Left = 138
        Top = 83
        Width = 80
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 6
        TabOrder = 2
        OnKeyPress = dbeClaFisDebitoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object edtDocRefDebito: TEditFocus
        Tag = 99
        Left = 138
        Top = 108
        Width = 80
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 3
        OnKeyPress = dbeClaFisCreditoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 1
        TipoTexto = ttAlfabetico
      end
      object edtMesAnoDebito: TEditFocus
        Tag = 99
        Left = 396
        Top = 108
        Width = 80
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 4
        OnKeyPress = dbeClaFisCreditoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 1
        TipoTexto = ttAlfabetico
      end
      object edtCbsIbsDebito: TEditFocus
        Tag = 99
        Left = 652
        Top = 108
        Width = 80
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 5
        OnKeyPress = dbeClaFisCreditoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 1
        TipoTexto = ttAlfabetico
      end
    end
    object cxDebito: TcxGrid
      Left = 0
      Top = 480
      Width = 1018
      Height = 200
      Align = alTop
      TabOrder = 2
      object cxGridDebito: TcxGridDBTableView
        OnKeyDown = cxGridDebitoKeyDown
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsDebito
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
          end
          item
            Kind = skCount
          end
          item
            Kind = skCount
          end
          item
            Kind = skSum
          end
          item
            Kind = skSum
          end
          item
            Kind = skCount
            Column = cxGridDebitoColumn1
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object cxGridDebitoColumn1: TcxGridDBColumn
          Caption = 'Tipo'
          DataBinding.FieldName = 'CCD_TIPFIN'
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Sorting = False
          Width = 30
        end
        object cxGridDebitoColumn2: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'CCD_TIPDES'
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Sorting = False
          Width = 220
        end
        object cxGridDebitoColumn3: TcxGridDBColumn
          Caption = 'CST'
          DataBinding.FieldName = 'CCD_CODCST'
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Sorting = False
          Width = 30
        end
        object cxGridDebitoColumn4: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'CCD_CSTDES'
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Sorting = False
          Width = 220
        end
        object cxGridDebitoColumn5: TcxGridDBColumn
          Caption = 'Class.Trib.'
          DataBinding.FieldName = 'CCD_CLATRI'
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Sorting = False
          Width = 52
        end
        object cxGridDebitoColumn6: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'CCD_CLADES'
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Sorting = False
          Width = 220
        end
        object cxGridDebitoColumn7: TcxGridDBColumn
          Caption = 'Chv.Ref.'
          DataBinding.FieldName = 'CCD_DOCREF'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          Options.Editing = False
          Options.Focusing = False
          Width = 50
        end
        object cxGridDebitoColumn8: TcxGridDBColumn
          Caption = 'M'#234's/Ano'
          DataBinding.FieldName = 'CCD_MESANO'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          Options.Editing = False
          Options.Focusing = False
          Width = 50
        end
        object cxGridDebitoColumn9: TcxGridDBColumn
          Caption = 'CBS e IBS'
          DataBinding.FieldName = 'CCD_CBSIBS'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          Options.Editing = False
          Options.Focusing = False
          Width = 50
        end
      end
      object cxGridLevelDebito: TcxGridLevel
        GridView = cxGridDebito
      end
    end
    object cxCredito: TcxGrid
      Left = 0
      Top = 140
      Width = 1018
      Height = 200
      Align = alTop
      TabOrder = 3
      object cxGridCredito: TcxGridDBTableView
        OnKeyDown = cxGridCreditoKeyDown
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsCredito
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
          end
          item
            Kind = skCount
          end
          item
            Kind = skCount
          end
          item
            Kind = skSum
          end
          item
            Kind = skSum
          end
          item
            Kind = skCount
            Column = cxGridCreditoColumn1
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object cxGridCreditoColumn1: TcxGridDBColumn
          Caption = 'Tipo'
          DataBinding.FieldName = 'CCD_TIPFIN'
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Moving = False
          Width = 30
        end
        object cxGridCreditoColumn2: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'CCD_TIPDES'
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Moving = False
          Width = 220
        end
        object cxGridCreditoColumn3: TcxGridDBColumn
          Caption = 'CST'
          DataBinding.FieldName = 'CCD_CODCST'
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Moving = False
          Width = 30
        end
        object cxGridCreditoColumn4: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'CCD_CSTDES'
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Moving = False
          Width = 220
        end
        object cxGridCreditoColumn5: TcxGridDBColumn
          Caption = 'Class.Trib.'
          DataBinding.FieldName = 'CCD_CLATRI'
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Moving = False
          Width = 52
        end
        object cxGridCreditoColumn6: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'CCD_CLADES'
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Moving = False
          Width = 220
        end
        object cxGridCreditoColumn7: TcxGridDBColumn
          Caption = 'Chv.Ref.'
          DataBinding.FieldName = 'CCD_DOCREF'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          Options.Editing = False
          Options.Focusing = False
          Width = 50
        end
        object cxGridCreditoColumn8: TcxGridDBColumn
          Caption = 'M'#234's/Ano'
          DataBinding.FieldName = 'CCD_MESANO'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          Options.Editing = False
          Options.Focusing = False
          Width = 50
        end
        object cxGridCreditoColumn9: TcxGridDBColumn
          Caption = 'CBS e IBS'
          DataBinding.FieldName = 'CCD_CBSIBS'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          Options.Editing = False
          Options.Focusing = False
          Width = 50
        end
      end
      object cxGridLevelCredito: TcxGridLevel
        GridView = cxGridCredito
      end
    end
    object pnlCredito: TPanel
      Left = 0
      Top = 0
      Width = 1018
      Height = 140
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Label3: TLabel
        Left = 18
        Top = 86
        Width = 117
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'd.Classifica'#231#227'o Trib.:'
        Layout = tlBottom
      end
      object Label4: TLabel
        Left = 18
        Top = 61
        Width = 117
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'd.Situa'#231#227'o Trib.:'
        Layout = tlBottom
      end
      object Label5: TLabel
        Left = 18
        Top = 36
        Width = 117
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'd.Tipo Cr'#233'dito :'
        Layout = tlBottom
      end
      object Label6: TLabel
        Left = 3
        Top = 111
        Width = 132
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Usa Chave Referenciada:'
        Layout = tlBottom
      end
      object clbCreditoDebito: TColorLabel
        Left = 221
        Top = 111
        Width = 61
        Height = 14
        Caption = '(S)im / (N)'#227'o'
        CorDestaque = clRed
      end
      object Label8: TLabel
        Left = 306
        Top = 111
        Width = 79
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Usa M'#234's/Ano:'
        Layout = tlBottom
      end
      object ColorLabel2: TColorLabel
        Left = 471
        Top = 111
        Width = 61
        Height = 14
        Caption = '(S)im / (N)'#227'o'
        CorDestaque = clRed
      end
      object Label9: TLabel
        Left = 561
        Top = 111
        Width = 79
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Usa CBS e IBS:'
        Layout = tlBottom
      end
      object ColorLabel3: TColorLabel
        Left = 726
        Top = 111
        Width = 61
        Height = 14
        Caption = '(S)im / (N)'#227'o'
        CorDestaque = clRed
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 1018
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        BevelWidth = 2
        Caption = 'Cr'#233'dito'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 8
      end
      object dbeClaFisCreditoDescr: TEditFocus
        Left = 221
        Top = 83
        Width = 791
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 9
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object dbeCstCreditoDescr: TEditFocus
        Left = 221
        Top = 58
        Width = 791
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 10
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object dbeTipoCreditoDescr: TEditFocus
        Left = 221
        Top = 33
        Width = 791
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 11
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object btnConfirmaCredito: TBitBtnLocked
        Left = 829
        Top = 108
        Width = 90
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
        TabOrder = 6
        OnClick = btnConfirmaCreditoClick
      end
      object btnCancelaCredito: TBitBtnLocked
        Left = 922
        Top = 108
        Width = 90
        Height = 22
        Caption = 'C&ancelar'
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
        TabOrder = 7
        OnClick = btnCancelaCreditoClick
      end
      object dbeTipoCredito: TEditFocus
        Tag = 99
        Left = 138
        Top = 33
        Width = 80
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 2
        TabOrder = 0
        OnKeyPress = dbeTipoCreditoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 2
        TipoTexto = ttNumerico
      end
      object dbeCstCredito: TEditFocus
        Tag = 99
        Left = 138
        Top = 58
        Width = 80
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 1
        OnKeyPress = dbeCstCreditoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object dbeClaFisCredito: TEditFocus
        Tag = 99
        Left = 138
        Top = 83
        Width = 80
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 6
        TabOrder = 2
        OnKeyPress = dbeClaFisCreditoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object edtDocRefCredito: TEditFocus
        Tag = 99
        Left = 138
        Top = 108
        Width = 80
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 3
        OnKeyPress = dbeClaFisCreditoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 1
        TipoTexto = ttAlfabetico
      end
      object edtMesAnoCredito: TEditFocus
        Tag = 99
        Left = 388
        Top = 108
        Width = 80
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 4
        OnKeyPress = dbeClaFisCreditoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 1
        TipoTexto = ttAlfabetico
      end
      object edtCbsIbsCredito: TEditFocus
        Tag = 99
        Left = 643
        Top = 108
        Width = 80
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 5
        OnKeyPress = dbeClaFisCreditoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 1
        TipoTexto = ttAlfabetico
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 752
    Top = 168
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 656
    Top = 176
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 576
    Top = 176
  end
  object dtsCredito: TDataSource
    DataSet = cdsCredito
    Left = 182
    Top = 214
  end
  object cdsCredito: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 120
    Top = 214
    object cdsCreditoCCD_TIPFIN: TStringField
      FieldName = 'CCD_TIPFIN'
      Size = 2
    end
    object cdsCreditoCCD_TIPDES: TStringField
      FieldName = 'CCD_TIPDES'
      Size = 150
    end
    object cdsCreditoCCD_CODCST: TStringField
      FieldName = 'CCD_CODCST'
      Size = 3
    end
    object cdsCreditoCCD_CSTDES: TStringField
      FieldName = 'CCD_CSTDES'
      Size = 150
    end
    object cdsCreditoCCD_CLATRI: TStringField
      FieldName = 'CCD_CLATRI'
      Size = 6
    end
    object cdsCreditoCCD_CLADES: TStringField
      FieldName = 'CCD_CLADES'
      Size = 150
    end
    object cdsCreditoCCD_DOCREF: TStringField
      FieldName = 'CCD_DOCREF'
      Size = 1
    end
    object cdsCreditoCCD_MESANO: TStringField
      FieldName = 'CCD_MESANO'
      Size = 1
    end
    object cdsCreditoCCD_CBSIBS: TStringField
      FieldName = 'CCD_CBSIBS'
      Size = 1
    end
  end
  object dtsDebito: TDataSource
    DataSet = cdsDebito
    Left = 158
    Top = 566
  end
  object cdsDebito: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 96
    Top = 566
    object StringField1: TStringField
      FieldName = 'CCD_TIPFIN'
      Size = 2
    end
    object StringField2: TStringField
      FieldName = 'CCD_TIPDES'
      Size = 150
    end
    object StringField3: TStringField
      FieldName = 'CCD_CODCST'
      Size = 3
    end
    object StringField4: TStringField
      FieldName = 'CCD_CSTDES'
      Size = 150
    end
    object StringField5: TStringField
      FieldName = 'CCD_CLATRI'
      Size = 6
    end
    object StringField6: TStringField
      FieldName = 'CCD_CLADES'
      Size = 150
    end
    object cdsDebitoCCD_DOCREF: TStringField
      FieldName = 'CCD_DOCREF'
      Size = 1
    end
    object cdsDebitoCCD_MESANO: TStringField
      FieldName = 'CCD_MESANO'
      Size = 1
    end
    object cdsDebitoCCD_CBSIBS: TStringField
      FieldName = 'CCD_CBSIBS'
      Size = 1
    end
  end
end
