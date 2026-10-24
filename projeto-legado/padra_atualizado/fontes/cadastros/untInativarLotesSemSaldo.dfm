inherited frmInativarLotesSemSaldo: TfrmInativarLotesSemSaldo
  Width = 1054
  Height = 672
  BorderStyle = bsSingle
  Caption = 'Inativar Lotes Sem Saldo'
  Position = poDesigned
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1054
  ExplicitHeight = 672
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 601
    Width = 1048
    TabOrder = 4
    ExplicitTop = 601
    ExplicitWidth = 1048
    object Label14: TLabel [0]
      Left = 350
      Top = 6
      Width = 262
      Height = 14
      Caption = '[ESPA'#199'O] -Para marcar o registro posicionado no grid.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 342
      Align = alNone
      ExplicitWidth = 342
      inherited btnConfirma: TBitBtnLocked
        Align = alLeft
        Caption = 'Confirma'
        ModalResult = 0
      end
      object BitBtnLocked1: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 130
        Height = 22
        Align = alLeft
        Caption = '&Marcar Todos'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000C0E0A1500000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000031362652909F70F32D32234C000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000003136265293A373F997A776FF93A373F92B3022490000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000003136265293A373F997A776FF97A776FF97A776FF93A273F82B2F
          2148000000000000000000000000000000000000000000000000000000000000
          00003136265393A373F997A776FF91A071F54951397B93A273F897A776FF93A2
          73F82B2F21480000000000000000000000000000000000000000000000000506
          0409839166DD97A776FF91A071F5262A1E40000000002B2F214893A273F897A7
          76FF93A273F82B30224900000000000000000000000000000000000000000000
          000015171023808D64D8262A1E400000000000000000000000002B2F214893A2
          73F897A776FF93A273F82B302249000000000000000000000000000000000000
          0000000000000202010300000000000000000000000000000000000000002B2F
          214893A273F897A776FF93A273F82B3022490000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00002B2F214893A273F897A776FF93A273F82B30224900000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000002B2F214893A273F897A776FF76825CC701010001000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000002B2F214875825CC60B0C081200000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000010100010000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 1
        OnClick = BitBtnLocked1Click
      end
      object BitBtnLocked2: TBitBtnLocked
        Left = 205
        Top = 0
        Width = 130
        Height = 22
        Align = alLeft
        Caption = '&Desmarcar Todos'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000F0F0F41000000000000000000000000000000000000
          0000000000000F0F0F4100000000000000000000000000000000000000000000
          0000000000001E1E1E813C3C3CFF1E1E1E810000000000000000000000000000
          00001E1E1E813C3C3CFF1E1E1E81000000000000000000000000000000000000
          00000F0F0F403C3C3CFF3C3C3CFF3C3C3CFF1E1E1E8100000000000000001E1E
          1E813C3C3CFF3C3C3CFF3C3C3CFF0F0F0F400000000000000000000000000000
          0000000000001E1E1E7E3C3C3CFF3C3C3CFF3C3C3CFF1E1E1E811E1E1E813C3C
          3CFF3C3C3CFF3C3C3CFF1E1E1E7E000000000000000000000000000000000000
          000000000000000000001E1E1E7E3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
          3CFF3C3C3CFF1E1E1E7E00000000000000000000000000000000000000000000
          00000000000000000000000000001E1E1E7E3C3C3CFF3C3C3CFF3C3C3CFF3C3C
          3CFF1E1E1E7E0000000000000000000000000000000000000000000000000000
          00000000000000000000000000001E1E1E813C3C3CFF3C3C3CFF3C3C3CFF3C3C
          3CFF1E1E1E810000000000000000000000000000000000000000000000000000
          000000000000000000001E1E1E813C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
          3CFF3C3C3CFF1E1E1E8100000000000000000000000000000000000000000000
          0000000000001E1E1E813C3C3CFF3C3C3CFF3C3C3CFF1E1E1E7E1E1E1E7E3C3C
          3CFF3C3C3CFF3C3C3CFF1E1E1E81000000000000000000000000000000000000
          00000F0F0F403C3C3CFF3C3C3CFF3C3C3CFF1E1E1E7E00000000000000001E1E
          1E7E3C3C3CFF3C3C3CFF3C3C3CFF0F0F0F400000000000000000000000000000
          0000000000001E1E1E7E3C3C3CFF1E1E1E7E0000000000000000000000000000
          00001E1E1E7E3C3C3CFF1E1E1E7E000000000000000000000000000000000000
          000000000000000000000F0F0F3E000000000000000000000000000000000000
          0000000000000F0F0F3E00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 2
        OnClick = BitBtnLocked2Click
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 969
      Top = 2
      Align = alRight
      ExplicitLeft = 969
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 627
    Width = 1048
    ExplicitTop = 627
    ExplicitWidth = 1048
    inherited pnlNomeForm: TPanel
      Left = 877
      ExplicitLeft = 877
    end
    inherited pnlInfo: TPanel
      Width = 877
      ExplicitWidth = 877
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 1048
    Height = 201
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Label9: TLabel
      Left = 63
      Top = 103
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Rua:'
    end
    object Label10: TLabel
      Left = 52
      Top = 126
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pr'#233'dio:'
    end
    object Label11: TLabel
      Left = 52
      Top = 149
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Andar:'
    end
    object Label12: TLabel
      Left = 20
      Top = 173
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Apartamento:'
    end
    object Label13: TLabel
      Left = 5
      Top = 80
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Loc. Separa'#231#227'o:'
    end
    object Label2: TLabel
      Left = 139
      Top = 149
      Width = 15
      Height = 14
      Caption = 'at'#233
    end
    object Label3: TLabel
      Left = 139
      Top = 173
      Width = 15
      Height = 14
      Caption = 'at'#233
    end
    object Label4: TLabel
      Left = 139
      Top = 103
      Width = 15
      Height = 14
      Caption = 'at'#233
    end
    object Label5: TLabel
      Left = 139
      Top = 126
      Width = 15
      Height = 14
      Caption = 'at'#233
    end
    object Label6: TLabel
      Left = 333
      Top = 173
      Width = 400
      Height = 14
      Caption = 
        '* N'#227'o informando o intervalo completo, ser'#225' considerado apenas o' +
        ' que foi digitado.'
    end
    object Label1: TLabel
      Left = 24
      Top = 32
      Width = 59
      Height = 14
      Caption = 'Fornecedor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 15
      Top = 56
      Width = 68
      Height = 14
      Caption = 'Linha / Grupo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 43
      Top = 8
      Width = 40
      Height = 14
      Caption = 'Produto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtRuaIni: TEditFocus
      Tag = 99
      Left = 86
      Top = 100
      Width = 47
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPredioIni: TEditFocus
      Tag = 99
      Left = 86
      Top = 123
      Width = 47
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtAndarIni: TEditFocus
      Tag = 99
      Left = 86
      Top = 146
      Width = 47
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtApartamentoIni: TEditFocus
      Tag = 99
      Left = 86
      Top = 169
      Width = 47
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 14
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodLse: TEditFocus
      Tag = 99
      Left = 86
      Top = 77
      Width = 46
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 6
      OnExit = edtCodLseExit
      OnKeyPress = edtCodLseKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesLse: TEditFocus
      Left = 133
      Top = 77
      Width = 372
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
    object edtRuaFin: TEditFocus
      Tag = 99
      Left = 160
      Top = 100
      Width = 47
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPredioFin: TEditFocus
      Tag = 99
      Left = 160
      Top = 123
      Width = 47
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtAndarFin: TEditFocus
      Tag = 99
      Left = 160
      Top = 146
      Width = 47
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 13
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtApartamentoFin: TEditFocus
      Tag = 99
      Left = 160
      Top = 169
      Width = 47
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 15
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnBuscar: TBitBtnLocked
      Left = 213
      Top = 169
      Width = 114
      Height = 25
      Caption = 'Buscar'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000020000000E0B14308329448DFB1D2F58A5000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000020000000E0D1937883C6DB2FF5BB1F9FF325196F4000000000000
        00000000000100000004000000090000000D0000000F0000000F0000000C0000
        00070000000E0F1D3C864A7CBCFF73C4FFFF467CC3FF17254485000000000000
        0002000000081C130F465A3B31BC7C5043F87F5244FF7B4E42FA57382FC11E14
        1059112142875686C2FF88D0FFFF5186C7FF142343880000000F000000010302
        02104A332C91946B5DFDC6ACA1FFE4D1C6FFEDDDD2FFE2D0C5FFC0A599FF855C
        50FF6E6B7EFF98D4F8FF5B8ECBFF152545840000000D00000002000000076046
        3DA6B39288FFE9DAD0FFDAC0A1FFCBA87AFFC49B66FFCCAA7EFFDCC2A5FFE5D2
        C6FF9A766AFF736A77FF162747850000000E00000002000000002A201D4AAE88
        7CFFEFE6DFFFCDA67CFFCDA26BFFE3C28CFFEDD5A2FFE7CD9EFFD3B182FFD0AE
        88FFE7D5CAFF885F53FF25181464000000070000000000000000755B53ACDFCE
        C9FFDDC1A8FFC99865FFE8BE83FFE9C388FFEDCA97FFEFD3A7FFF2D9B0FFD5B1
        87FFDBBEA6FFC5ACA2FF5A3D33C10000000C0000000000000000A9877CE9F8F4
        F2FFC79873FFDEAB77FFEFCDABFFF0D0B1FFEDC9A1FFECC69AFFEFCFA9FFE9C9
        A4FFC89B77FFE6D6CEFF7C5448F10000000F0000000000000000C09C90FFFDFD
        FCFFBE875FFFEDCFB9FFF5DFD2FFF2D6C1FFF1CFB4FFEDC6A4FFECC19BFFEFC8
        A6FFC08B67FFF1E6DFFF8B6154FF0000000F0000000000000000AF9186E6F9F5
        F4FFC69474FFE8CDC3FFF9E8E4FFF6DED2FFF3D4C2FFF0CBB2FFEBB78EFFE5B7
        92FFC59172FFEBDFD9FF866055EE0000000D0000000000000000876F68B0E7D9
        D4FFE2C6B7FFC89072FFFAEFF2FFF9E7E4FFF6DDD3FFF1C8B2FFEBAF88FFC98E
        6CFFDCBBAAFFD3C0B7FF6B4F46BC00000009000000000000000026201E36CCAF
        A7FAFBF8F7FFCF9F88FFC78E72FFE9CDC6FFEDC7B5FFDD9F79FFC88865FFCE9D
        84FFF5EFEBFFB39387FF2A201D52000000040000000000000000000000036454
        4F84D9C2BAFFFDFBFAFFE2C6B8FFCB977EFFC08163FFCB977DFFE0C4B4FFFAF6
        F5FFC9B0A7FF6B564EA700000009000000010000000000000000000000000202
        020762534D81CEB2A9FAEADDD8FFF9F5F4FFFFFFFFFFF9F5F4FFE9DCD7FFC8AC
        A2FC62504B900404031000000002000000000000000000000000000000000000
        000000000003241F1D3486726BADB69B91E6CCADA1FFB99C92E988736CB22822
        1F3E000000060000000100000000000000000000000000000000}
      TabOrder = 16
      OnClick = btnBuscarClick
    end
    object edtCodFor: TEditFocus
      Left = 86
      Top = 29
      Width = 60
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentFont = False
      TabOrder = 2
      OnExit = edtCodForExit
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesFor: TEditFocus
      Left = 149
      Top = 29
      Width = 356
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskLinGru: TMaskEditFocus
      Left = 86
      Top = 53
      Width = 60
      Height = 22
      EditMask = '999.999;0;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      TabOrder = 4
      Text = ''
      OnExit = mskLinGruExit
      OnKeyPress = mskLinGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGru: TEditFocus
      Left = 149
      Top = 53
      Width = 356
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodIte: TEditFocus
      Left = 86
      Top = 5
      Width = 60
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 0
      OnExit = edtCodIteExit
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesIte: TEditFocus
      Left = 149
      Top = 5
      Width = 356
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object cxgCadLot: TcxGridCitel [4]
    Left = 0
    Top = 201
    Width = 1048
    Height = 400
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgCadLotDBTableViewCitel: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = True
      CorZebra = clMoneyGreen
      object cxgCadLotDBTableViewCitelMARCA: TcxGridDBColumn
        Caption = '  X'
        DataBinding.FieldName = 'MARCA'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        Width = 26
      end
      object cxgCadLotDBTableViewCitelCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 52
      end
      object cxgCadLotDBTableViewCitelDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 452
      end
      object cxgCadLotDBTableViewCitelDTAVAL: TcxGridDBColumn
        Caption = 'Validade'
        DataBinding.FieldName = 'DTAVAL'
        Options.Editing = False
        Options.Focusing = False
      end
      object cxgCadLotDBTableViewCitelLOCFIS: TcxGridDBColumn
        Caption = 'Localiza'#231#227'o'
        DataBinding.FieldName = 'LOCFIS'
        Options.Editing = False
        Options.Focusing = False
        Width = 80
      end
      object cxgCadLotDBTableViewCitelCRITIC: TcxGridDBColumn
        Caption = 'Cr'#237'tico'
        DataBinding.FieldName = 'CRITIC'
        Options.Editing = False
        Options.Focusing = False
        Width = 45
      end
      object cxgCadLotDBTableViewCitelPICKIN: TcxGridDBColumn
        Caption = 'Picking'
        DataBinding.FieldName = 'PICKIN'
        Options.Editing = False
        Options.Focusing = False
        Width = 50
      end
      object cxgCadLotDBTableViewCitelNUMLOT: TcxGridDBColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'NUMLOT'
        Options.Editing = False
        Options.Focusing = False
      end
      object cxgCadLotDBTableViewCitelCODLSE: TcxGridDBColumn
        Caption = 'C'#243'd. Local Sep.'
        DataBinding.FieldName = 'CODLSE'
        Options.Editing = False
        Options.Focusing = False
      end
      object cxgCadLotDBTableViewCitelLSEDES: TcxGridDBColumn
        Caption = 'Local de Separa'#231#227'o'
        DataBinding.FieldName = 'LSEDES'
        Options.Editing = False
        Options.Focusing = False
      end
      object cxgCadLotDBTableViewCitelR_U_A_: TcxGridDBColumn
        Caption = 'Rua'
        DataBinding.FieldName = 'R_U_A_'
        Options.Editing = False
        Options.Focusing = False
        Width = 50
      end
      object cxgCadLotDBTableViewCitelPREDIO: TcxGridDBColumn
        Caption = 'Pr'#233'dio'
        DataBinding.FieldName = 'PREDIO'
        Options.Editing = False
        Options.Focusing = False
        Width = 56
      end
      object cxgCadLotDBTableViewCitelANDAR_: TcxGridDBColumn
        Caption = 'Andar'
        DataBinding.FieldName = 'ANDAR_'
        Options.Editing = False
        Options.Focusing = False
      end
      object cxgCadLotDBTableViewCitelAPARTA: TcxGridDBColumn
        Caption = 'Apartamento'
        DataBinding.FieldName = 'APARTA'
        Options.Editing = False
        Options.Focusing = False
        Width = 70
      end
    end
    object cxgCadLotLevel: TcxGridLevel
      GridView = cxgCadLotDBTableViewCitel
    end
  end
end
