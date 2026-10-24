inherited frmConsultarAdiantamentos: TfrmConsultarAdiantamentos
  Left = 229
  Top = 288
  Width = 1048
  Height = 600
  BorderIcons = [biSystemMenu]
  Caption = 'Consulta de Adiantamentos do Cliente - Pedido de Venda'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 1048
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 523
    Width = 1042
    Height = 32
    BevelInner = bvNone
    BevelOuter = bvRaised
    BorderWidth = 4
    Color = 16770261
    TabOrder = 2
    ExplicitTop = 523
    ExplicitWidth = 1042
    ExplicitHeight = 32
    inherited FlwBotoes: TFlowPanel
      Left = 5
      Top = 5
      Width = 1032
      Height = 22
      TabOrder = 1
      ExplicitLeft = 6
      ExplicitTop = 5
      ExplicitWidth = 1032
      ExplicitHeight = 22
      object btnReimprimir: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 181
        Height = 22
        Align = alLeft
        Caption = '[F2] Reimprimir Comprovante'
        Enabled = False
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF9F9D9EFF00FFFF00FFFF00FF8281818281818E8A
          8BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F9D9E9F9D9ED4D1D196
          93933B393A545253999797C5C2C4D7D5D5828181FF00FFFF00FFFF00FFFF00FF
          9F9D9E9F9D9EFAFAFAFFFFFFD7D4D59E9C9C4443451C1C1E1C1C1F3534356766
          678281818E8A8BFF00FF918E8F9F9D9EF0EEEFFFFFFFEEEBEBCAC9C99F9D9E8E
          8A8A9793958786866463633C3B3D1F2022201F21747273FF00FF9C9899E9E7E7
          E5E5E5BDBBBBA6A4A4B4B1B1C2C1C1A4A1A19692939290909793959A98988E8A
          8B6B6A6A828181FF00FF959192ADABACA4A1A1B0AFAFC9C9C9D1D3D3EDEDEBF0
          EEF0DCDADAC5C4C4ADABAB9A98999390909793958E8A8BFF00FF918E8FAFADAF
          C9C7C7CECECEC9C9C9E2E2E2D1CFCFA1ABA1BDBCBCCBCECFD5D5D5D3D3D3C6C5
          C5B6B6B6989797FF00FFFF00FF9C999AD0D1D1CFCFCFDCDCDCC9C6C6B5B0B4A5
          D1A7BAC4BCC5A7A1ADA4A3A9A6A7B4B1B2C2C1C1A9A6A7FF00FFFF00FFFF00FF
          9C999AC1BFBFAFADADB1B0B0E3E3E3F6F3F3EEEDEEEDE1DEDCD8D8CCCCCCB4B4
          B4939091FF00FFFF00FFFF00FFFF00FFFF00FF9C999AD8DADACACACB9D9FA0BB
          BFC1D3D5D7D4D9D9D5D5D5C6C5C6AFADADFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFBE5E1F8E0D4E9C9BDE3C7BDE2CCC7DED3CED0CECC959295FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDECEFFCFBDFF
          C4AFFFBAA3FFB199FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFCE9F9DFFDDCEFFCCBCFEC2B0FFBBA4F7A992FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDDCEFFCCBCFE
          C2B0FEB8A3FAB099FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFCE9F9DFAE0D5FFDACCFFCEBDFFC6B1FCB8A3F8AD99FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DCE9F9DCE9F9DCE9F9DF3
          AD9DF3AD9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        OnClick = btnReimprimirClick
      end
      object btnGerarCredito: TBitBtnLocked
        Left = 181
        Top = 0
        Width = 372
        Height = 22
        Align = alLeft
        Caption = 
          '[F3] Transformar Adiantamento em Cr'#233'dito no Conta Corrente do Cl' +
          'iente'
        Enabled = False
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
        TabOrder = 1
        OnClick = btnGerarCreditoClick
      end
      object btnEstornarCredito: TBitBtnLocked
        Left = 553
        Top = 0
        Width = 372
        Height = 22
        Align = alLeft
        Caption = '[F4] Estornar Cr'#233'dito Gerado e Voltar o Saldo como Adiantamento '
        Enabled = False
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
        TabOrder = 2
        OnClick = btnEstornarCreditoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 947
      Top = 5
      Width = 93
      TabOrder = 0
      ExplicitLeft = 947
      ExplicitTop = 5
      ExplicitWidth = 93
    end
  end
  object pnlHeader: TPanel [2]
    Left = 0
    Top = 0
    Width = 1042
    Height = 81
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 0
    object Label5: TLabel
      Left = 12
      Top = 10
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
    end
    object Label4: TLabel
      Left = 205
      Top = 10
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie:'
    end
    object Label1: TLabel
      Left = 24
      Top = 34
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label3: TLabel
      Left = 34
      Top = 58
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 72
      Top = 6
      Width = 125
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 12
      TabOrder = 0
      OnEnter = edtNumDocEnter
      OnKeyPress = edtNumDocKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 248
      Top = 6
      Width = 28
      Height = 22
      TabStop = False
      Alignment = taCenter
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 2
      ReadOnly = True
      TabOrder = 1
      Text = 'PD'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 72
      Top = 30
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 2
      OnEnter = edtNumDocEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmp: TEditFocus
      Left = 129
      Top = 30
      Width = 429
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 72
      Top = 54
      Width = 57
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 3
      ReadOnly = True
      TabOrder = 4
      OnEnter = edtNumDocEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 129
      Top = 54
      Width = 429
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlDescricao: TPanel [3]
    Left = 0
    Top = 499
    Width = 1042
    Height = 24
    Align = alBottom
    BorderWidth = 4
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object lblDescricao: TLabel
      Left = 68
      Top = 5
      Width = 4
      Height = 14
      Align = alLeft
      Caption = '-'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object lblTitDescricao: TLabel
      Left = 5
      Top = 5
      Width = 63
      Height = 14
      Align = alLeft
      Caption = ' Descri'#231#227'o: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
  end
  object dbgAdiantamentos: TDBGridCitel [4]
    Left = 0
    Top = 81
    Width = 1042
    Height = 418
    Align = alClient
    DataSource = dtsAdiantamentos
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgAdiantamentosDrawColumnCell
    OnKeyDown = dbgAdiantamentosKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DTALAN'
        Title.Alignment = taCenter
        Title.Caption = 'Data'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = []
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'HORLAN'
        Title.Alignment = taCenter
        Title.Caption = 'Hora'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = []
        Width = 51
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'EMPLAN'
        Title.Alignment = taCenter
        Title.Caption = 'Emp.'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = []
        Width = 30
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'OPELAN'
        Title.Alignment = taCenter
        Title.Caption = 'Ope.'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = []
        Width = 32
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'SEQCON'
        Title.Alignment = taCenter
        Title.Caption = 'Seq. Baixa'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = []
        Width = 59
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'TIPLAN'
        Title.Alignment = taCenter
        Title.Caption = 'C/D'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = []
        Width = 23
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALDIN'
        Title.Alignment = taRightJustify
        Title.Caption = 'Dinheiro'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = []
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALCHV'
        Title.Alignment = taRightJustify
        Title.Caption = 'Cheque (Vista)'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = []
        Width = 78
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALCHP'
        Title.Alignment = taRightJustify
        Title.Caption = 'Cheque (Pr'#233')'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = []
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALCAR'
        Title.Alignment = taRightJustify
        Title.Caption = 'Cart'#227'o'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = []
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALORD'
        Title.Alignment = taRightJustify
        Title.Caption = 'Ordem Pagto'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = []
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALFIN'
        Title.Alignment = taRightJustify
        Title.Caption = 'Financiamento'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = []
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALCRE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Utiliz. Cr'#233'ditos'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = []
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALLAN'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Total'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = []
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SALFIN'
        Title.Alignment = taRightJustify
        Title.Caption = 'Saldo Final'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = []
        Width = 80
        Visible = True
      end>
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 1042
    TabOrder = 3
    ExplicitTop = 555
    ExplicitWidth = 1042
    inherited pnlNomeForm: TPanel
      Left = 871
      ExplicitLeft = 871
    end
    inherited pnlInfo: TPanel
      Width = 871
      ExplicitWidth = 871
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 640
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 720
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 680
    Top = 8
  end
  object dtsAdiantamentos: TDataSource
    Left = 600
    Top = 8
  end
end
