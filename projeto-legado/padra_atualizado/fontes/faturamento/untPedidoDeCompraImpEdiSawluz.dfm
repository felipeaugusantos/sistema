inherited frmPedidoDeCompraImpEdiSawluz: TfrmPedidoDeCompraImpEdiSawluz
  Width = 806
  Height = 412
  Caption = 'Importa'#231#227'o de Pedido de Compra - Autcom'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 806
  ExplicitHeight = 412
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 339
    Width = 800
    ExplicitTop = 339
    ExplicitWidth = 800
    inherited FlwBotoes: TFlowPanel
      Width = 796
      ExplicitWidth = 796
    end
  end
  inherited pnlStatus: TPanel
    Top = 367
    Width = 800
    ExplicitTop = 367
    ExplicitWidth = 800
    inherited pnlNomeForm: TPanel
      Left = 629
      ExplicitLeft = 629
    end
    inherited pnlInfo: TPanel
      Width = 629
      ExplicitWidth = 629
    end
  end
  inherited pgcDados: TPageControl
    Left = -10
    Top = -10
    Width = 17
    Height = 9
    Align = alNone
    Visible = False
    ExplicitLeft = -10
    ExplicitTop = -10
    ExplicitWidth = 17
    ExplicitHeight = 9
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 9
      ExplicitHeight = 428
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 800
    Height = 158
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object grbArquivo: TGroupBox
      Left = 1
      Top = 1
      Width = 649
      Height = 156
      Align = alClient
      TabOrder = 0
      DesignSize = (
        649
        156)
      object Label1: TLabel
        Left = 12
        Top = 14
        Width = 41
        Height = 14
        Hint = '999'
        Caption = 'Arquivo:'
      end
      object gauProgresso: TGauge
        Left = 57
        Top = 39
        Width = 588
        Height = 18
        Anchors = [akLeft, akTop, akRight]
        PopupMenu = mnuAuxiliar
        Progress = 0
        ExplicitWidth = 590
      end
      object flnArqTxt: TFilenameEditFocus
        Left = 57
        Top = 11
        Anchors = [akLeft, akTop, akRight]
        PopupMenu = mnuAuxiliar
        Properties.Buttons = <
          item
            Default = True
            Glyph.SourceDPI = 96
            Glyph.Data = {
              424D360400000000000036000000280000001000000010000000010020000000
              000000000000C40E0000C40E0000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000004020FF406040FF406040FF4060
              40FF004020FF0000000000000000000000000000000000000000806040FFC080
              60FFC06060FFC0A080FFA4A0A0FF408060FF40A080FF40C080FF40C080FF40C0
              80FF40A060FF408060FF00000000000000000000000000000000C08060FFFFFF
              FFFFFFFFFFFFC0DCC0FF408060FF40C0A0FF40C0A0FF40A060FF408060FF40A0
              60FF40C0A0FF40C080FF408060FF000000000000000000000000C08060FFFFFF
              FFFFF0FBFFFF80A0A0FF40C0A0FF40E0A0FF40C0A0FF408060FFFFFFFFFF4080
              60FF40E0A0FF40C0A0FF40A080FF004040FF0000000000000000C08060FFFFFF
              FFFFF0FBFFFF40A080FF80E0C0FF40A080FF408060FF408060FFF0FBFFFF4080
              60FF408060FF40A080FF40C0A0FF408060FF0000000000000000C08060FFFFFF
              FFFFFFFFFFFF40A060FF80E0C0FF408060FFC0DCC0FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF408060FF40E0A0FF408060FF0000000000000000C08060FFFFFF
              FFFFFFFFFFFF40A080FFC0DCC0FF80A080FF408060FF408060FFFFFFFFFF4080
              60FF408060FF40A080FF80E0C0FF408060FF0000000000000000C08080FFFFFF
              FFFFFFFFFFFF80C0A0FF80C0C0FFF0FBFFFFF0FBFFFF40A080FFF0FBFFFF40A0
              80FFC0DCC0FFC0DCC0FF80C0A0FF406040FF0000000000000000C08080FFFFFF
              FFFFFFFFFFFFF0FBFFFF40A080FFC0DCC0FFF0FBFFFF80C0A0FF40A080FF80A0
              A0FFF0FBFFFFC0DCC0FF40A080FF000000000000000000000000C08080FFFFFF
              FFFFFFFFFFFFFFFFFFFFC0DCC0FF40A080FF80C0C0FFF0FBFFFFF0FBFFFFF0FB
              FFFF80C0C0FF40A080FF004020FF000000000000000000000000C08080FFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FBFFFF80C0C0FF40C080FF40A080FF40C0
              80FF80C0C0FFC0C0C0FF00000000000000000000000000000000C0A080FFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFC0A080FF00000000000000000000000000000000C0A080FFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFC08080FF00000000000000000000000000000000C0A080FFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFC0A080FF00000000000000000000000000000000808060FFC0A0
              80FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A0
              80FFC0A080FF808060FF000000000000000000000000}
            Kind = bkGlyph
          end>
        StyleFocused.Color = clInfoBk
        TabOrder = 0
        OnExit = flnArqTxtExit
        Width = 588
      end
      object chkImprime: TCheckBox
        Left = 57
        Top = 58
        Width = 336
        Height = 17
        Caption = 'Imprimir pedido ap'#243's a grava'#231#227'o'
        TabOrder = 1
      end
      object rdgTabPre: TRadioGroup
        Left = 57
        Top = 84
        Width = 301
        Height = 62
        Caption = 'Tabela de pre'#231'o que ser'#225' utilizado na grava'#231#227'o do pedido:'
        ItemIndex = 0
        Items.Strings = (
          'Tabela de Pre'#231'o do Cliente / Regras do Faturamento'
          'Pre'#231'os definidos no arquivo')
        TabOrder = 2
      end
    end
    object Panel4: TPanel
      Left = 650
      Top = 1
      Width = 149
      Height = 156
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object gpbLegendas: TGroupBox
        Left = 1
        Top = 1
        Width = 147
        Height = 56
        Caption = 'Legenda'
        TabOrder = 0
        object Shape1: TShape
          Left = 10
          Top = 16
          Width = 17
          Height = 15
          Brush.Color = clRed
          Pen.Color = clRed
          Pen.Style = psClear
          Shape = stCircle
        end
        object Label2: TLabel
          Left = 38
          Top = 16
          Width = 26
          Height = 14
          Caption = 'Erros'
        end
        object Label3: TLabel
          Left = 38
          Top = 35
          Width = 34
          Height = 14
          Caption = 'Avisos'
        end
        object Shape2: TShape
          Left = 10
          Top = 35
          Width = 17
          Height = 15
          Brush.Color = clYellow
          Pen.Color = clRed
          Pen.Style = psClear
          Shape = stCircle
        end
      end
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 158
    Width = 800
    Height = 181
    Align = alClient
    ParentColor = True
    TabOrder = 4
    object DBGrid1: TDBGridCitel
      Left = 1
      Top = 1
      Width = 798
      Height = 179
      Align = alClient
      BorderStyle = bsNone
      DataSource = dtsOcorrencias
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      ParentColor = True
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = DBGrid1DrawColumnCell
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'LINHA'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CAMPO'
          Width = 442
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OCORRENCIA'
          Width = 1363
          Visible = True
        end>
    end
  end
  object Panel3: TPanel [5]
    Left = 0
    Top = 339
    Width = 800
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 5
    object BitBtnLocked1: TBitBtnLocked
      Left = 701
      Top = 2
      Width = 97
      Height = 24
      Align = alRight
      Caption = '&Sair'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000001000000520000006B
        0000006B0800106B0800008C080000940800007B100000731800087B180008A5
        1800089C21001094290010A529001084310010A5310018A5310010A539001884
        4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
        4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
        5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
        AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
        BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
        CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
        D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
        DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
        F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
        FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
        FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
        5959595959595959595932514E32323232325959595959595959325266655F5F
        5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
        1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
        21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
        44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
        372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
        4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
        6A4A231B59595959595959592626262626262359595959595959}
      TabOrder = 1
      OnClick = btnSairClick
    end
    object btnConfirma: TBitBtnLocked
      Left = 5
      Top = 3
      Width = 97
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
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnLimpa: TBitBtnLocked
      Left = 104
      Top = 3
      Width = 97
      Height = 22
      Caption = '&Limpar'
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btnLimpaClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 248
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 216
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 608
    Top = 80
  end
  object cdsOcorrencias: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'TIPO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'LINHA'
        DataType = ftInteger
      end
      item
        Name = 'CAMPO'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'OCORRENCIA'
        DataType = ftString
        Size = 300
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 160
    Top = 136
    object cdsOcorrenciasTIPO: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 4
      FieldName = 'TIPO'
      Size = 1
    end
    object cdsOcorrenciasLINHA: TIntegerField
      DisplayLabel = 'N'#186' Linha'
      DisplayWidth = 9
      FieldName = 'LINHA'
    end
    object cdsOcorrenciasCAMPO: TStringField
      DisplayLabel = 'Campo'
      DisplayWidth = 43
      FieldName = 'CAMPO'
      Size = 60
    end
    object cdsOcorrenciasOCORRENCIA: TStringField
      DisplayLabel = 'Ocorr'#234'ncia'
      DisplayWidth = 91
      FieldName = 'OCORRENCIA'
      Size = 300
    end
  end
  object dtsOcorrencias: TDataSource
    DataSet = cdsOcorrencias
    Left = 248
    Top = 136
  end
end
