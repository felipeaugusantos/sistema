object frmDigDadConsumidor: TfrmDigDadConsumidor
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Dados do Consumidor'
  ClientHeight = 245
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBotoes: TPanel
    Left = 0
    Top = 209
    Width = 482
    Height = 36
    Align = alBottom
    TabOrder = 1
    object btnCancelar: TcxButton
      Left = 399
      Top = 6
      Width = 75
      Height = 25
      Caption = 'C&ancelar'
      Colors.Hot = clMoneyGreen
      LookAndFeel.Kind = lfOffice11
      LookAndFeel.NativeStyle = False
      OptionsImage.Glyph.SourceDPI = 96
      OptionsImage.Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00015603FF015603FF0156
        03FF015603FFFF00FF00000082FF000082FF000082FF000082FF000082FF0000
        82FF000082FF000082FF000082FF000082FF000082FF015603FF2DC651FF1DB2
        36FF015603FFFF00FF00000082FF011EF3FF0527FBFF1337FBFF3052FCFF5F7D
        FEFFA1B4FFFFF2F6FFFFFFFFFFFFFFFFFFFF000082FF015603FF3FD96DFF30C9
        56FF015603FFFF00FF00000082FF0120FBFF0528FCFF1438FCFF3154FEFF607F
        FFFFA5B7FFFFF6FAFFFFFFFFFFFFFFFFFFFF000082FF015603FF015603FF0156
        03FF015603FFFF00FF00000082FF000082FF000082FF000082FF000082FF0000
        82FF000082FF000082FF000082FF000082FF000082FFFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00015603FF015603FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000156
        03FF41E074FF28AC47FF015603FF015603FFFF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00035A05FF015603FFFF00FF00FF00FF00FF00FF000156
        03FF2DC450FF35CE5DFF188F2CFF015603FFFF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00045F09FF188E2BFF015603FFFF00FF00FF00FF00015603FF0E8F
        1CFF19AB31FF22B53EFF035E07FFFF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0005630AFF2DB750FF015603FFFF00FF00FF00FF00FF00FF00015603FF0156
        03FF036507FF11A322FF16A429FF046007FF025804FF015704FF045F08FF0E78
        19FF2FBC55FF015603FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00015603FF026305FF0A9815FF0FA01FFF0D891AFF108E1FFF1CA634FF2ABD
        4AFF015603FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00015603FF015603FF05840CFF088E11FF0D971AFF0D971AFF0156
        03FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00015603FF015603FF015603FF015603FFFF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      TabOrder = 1
      OnClick = btnCancelarClick
    end
    object btnConfirma: TcxButton
      Left = 5
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Confirma'
      Colors.Hot = clMoneyGreen
      LookAndFeel.Kind = lfOffice11
      LookAndFeel.NativeStyle = False
      OptionsImage.Glyph.SourceDPI = 96
      OptionsImage.Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00313131FF313131FF313131FF313131FFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00313131FF746B6DFF7A7676FF747575FF828282FF313131FF3131
        31FF313131FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00313131FF726E72FF6A6669FF7D797AFF292929FF383838FF424242FF2828
        28FF686868FF313131FF313131FF313131FFFF00FF00FF00FF00FF00FF003131
        31FF6F6C6FFF747074FF6D6A6DFF7D797BFF6C6D6DFF4C4C4CFF1F1F1FFF0000
        00FF000000FF090909FF757274FF777277FF424141FFFF00FF00313131FFCCCA
        CEFFC9C4C9FF999398FF696669FFE5E2E5FFD8D9D9FFACACACFF8E8E8EFF5252
        52FF232323FF201F20FF3D483DFF3C563CFF424141FF313131FF929193FFD7D5
        D9FFD7D5D8FFF2F4F6FF808284FF6D6C6DFFA4A3A4FFD8D8D8FFE9EBEBFFE3EA
        EAFFD4D9D9FFADACAFFF6F836FFF388239FF424141FF313131FFEFEEF2FFE5E5
        E9FFF7F6F6FFCFACACFFC4A6A9FF929698FF6A6B6CFF515253FF6D6364FFA783
        84FFC4ADAFFFD3D0D1FFE6E3E5FFD8D8D8FF424141FF313131FFFCFCFCFFFEFF
        FFFFCA9895FFB43837FF934041FF826263FFBFACABFFD0D0D1FFB58888FF7D12
        11FF9C3C3DFF766D6EFF6E6869FF626060FFFF00FF00313131FFFFFFFFFFFFFF
        FFFF9F3536FFBC4242FFA35555FF7F2A28FFAC6C6BFFFFFFFFFFD1A4A4FF7B14
        14FF9F3536FF2D2C2CFF2D2C2CFFFF00FF00FF00FF003F3F3FFF313131FFCACE
        CFFF9F3536FFBD4241FFAB5353FF9A5453FF895354FFCAC5C2FFCC9292FF8217
        17FF9F3536FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF003131
        31FF9F3536FFB84442FFB64F4FFFC16968FFBC6363FFB85959FFBD5E5DFFBF58
        58FF9F3536FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF009F3536FFB5635FFFE9D5D4FFEEDEDDFFEFDDDCFFEEDAD9FFF2E6E5FFC47B
        79FF9F3536FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF009F3536FFC47E7AFFF3FBF8FFC5C2C1FFC5C2C1FFC5C2C1FFE7EBEBFFC47B
        79FF9F3536FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF009F3536FFC17A78FFF3F3F3FFDDD8D7FFDDD8D7FFDDD8D7FFE3E6E5FFC47B
        79FF9F3536FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF009F3536FFC47B79FFF3F3F3FFC5C2C1FFC5C2C1FFC5C2C1FFE3E6E5FFC47B
        79FF9F3536FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00B1706EFFCCC6C6FFCCC6C6FFCCC6C6FFCCC6C6FFCCC6C6FFB170
        6EFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
  end
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 482
    Height = 209
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 66
      Top = 37
      Width = 31
      Height = 13
      Alignment = taRightJustify
      Caption = 'Nome:'
    end
    object Label2: TLabel
      Left = 48
      Top = 60
      Width = 49
      Height = 13
      Alignment = taRightJustify
      Caption = 'Endere'#231'o:'
    end
    object Label3: TLabel
      Left = 65
      Top = 83
      Width = 32
      Height = 13
      Alignment = taRightJustify
      Caption = 'Bairro:'
    end
    object Label4: TLabel
      Left = 60
      Top = 106
      Width = 37
      Height = 13
      Alignment = taRightJustify
      Caption = 'Cidade:'
    end
    object Label5: TLabel
      Left = 318
      Top = 129
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = 'Telefone:'
    end
    object Label6: TLabel
      Left = 73
      Top = 129
      Width = 23
      Height = 13
      Alignment = taRightJustify
      Caption = 'CEP:'
    end
    object Label7: TLabel
      Left = 363
      Top = 106
      Width = 37
      Height = 13
      Alignment = taRightJustify
      Caption = 'Estado:'
    end
    object Label9: TLabel
      Left = 19
      Top = 14
      Width = 78
      Height = 13
      Alignment = taRightJustify
      Caption = '1-CNPJ / 2-CPF:'
    end
    object lblIncEst: TLabel
      Left = 273
      Top = 152
      Width = 91
      Height = 13
      Alignment = taRightJustify
      Caption = 'Inscri'#231#227'o Estadual:'
      Visible = False
    end
    object lblRg: TLabel
      Left = 79
      Top = 152
      Width = 18
      Height = 13
      Alignment = taRightJustify
      Caption = 'RG:'
    end
    object lbl1: TLabel
      Left = 65
      Top = 175
      Width = 32
      Height = 13
      Alignment = taRightJustify
      Caption = 'E-mail:'
    end
    object edtNomCli: TEditFocus
      Tag = 99
      Left = 102
      Top = 33
      Width = 364
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 40
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtEndere: TEditFocus
      Tag = 99
      Left = 102
      Top = 56
      Width = 364
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 40
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtBairro: TEditFocus
      Tag = 99
      Left = 102
      Top = 79
      Width = 256
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 40
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskTelCon: TMaskEditFocus
      Tag = 99
      Left = 369
      Top = 125
      Width = 97
      Height = 21
      EditMask = '(99)9999-9999;0;_'
      MaxLength = 13
      TabOrder = 8
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskNumCep: TMaskEditFocus
      Tag = 99
      Left = 102
      Top = 125
      Width = 63
      Height = 21
      EditMask = '99999-999;0;_'
      MaxLength = 9
      TabOrder = 7
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCgcCpf: TEditFocus
      Tag = 99
      Left = 102
      Top = 10
      Width = 38
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 0
      OnChange = edtCgcCpfChange
      OnExit = edtCgcCpfExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtInsEst: TEditFocus
      Tag = 99
      Left = 369
      Top = 148
      Width = 97
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      MaxLength = 20
      TabOrder = 10
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtEstado: TEditFocus
      Left = 404
      Top = 102
      Width = 62
      Height = 21
      TabStop = False
      Alignment = taLeftJustify
      Color = clMoneyGreen
      Enabled = False
      ReadOnly = True
      TabOrder = 6
      NormalColor = clMoneyGreen
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRgCli: TEditFocus
      Left = 102
      Top = 148
      Width = 163
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 20
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskNumCgc: TMaskEditFocus
      Tag = 99
      Left = 141
      Top = 10
      Width = 134
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 20
      TabOrder = 1
      Text = ''
      OnExit = mskNumCgcExit
      OnKeyPress = mskNumCgcKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object dbeCidade: TcxExtLookupComboBox
      AlignWithMargins = True
      Left = 102
      Top = 102
      Properties.AutoSearchOnPopup = False
      Properties.AutoSelect = False
      Properties.DropDownHeight = 230
      Properties.DropDownRows = 10
      Properties.DropDownSizeable = True
      Properties.DropDownWidth = 350
      Properties.FocusPopup = True
      Properties.HideSelection = False
      Properties.IncrementalFiltering = False
      Properties.View = cxGridCadCid
      Properties.KeyFieldNames = 'CID_CODCID'
      Properties.ListFieldItem = cxColNomCid
      Properties.OnChange = dbeCidadePropertiesChange
      Style.BorderStyle = ebs3D
      Style.ButtonTransparency = ebtNone
      TabOrder = 5
      Width = 256
    end
    object edtEmail: TEditFocus
      Tag = 99
      Left = 102
      Top = 171
      Width = 364
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecLowerCase
      MaxLength = 40
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object cxGridRepository: TcxGridViewRepository
    Left = 280
    object cxGridCadCid: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      FilterBox.CustomizeDialog = False
      DataController.DataSource = dtsCadCid
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.KeyFieldNames = 'CID_CODCID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para filtrar'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsCustomize.ColumnGrouping = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxColCodCid: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CID_CODCID'
        Width = 51
      end
      object cxColNomCid: TcxGridDBColumn
        Caption = 'Nome'
        DataBinding.FieldName = 'CID_NOMCID'
        Width = 217
      end
      object cxColEstado: TcxGridDBColumn
        Caption = 'Estado'
        DataBinding.FieldName = 'CID_ESTADO'
        Width = 42
      end
    end
  end
  object dtsCadCid: TDataSource
    Left = 312
  end
end
