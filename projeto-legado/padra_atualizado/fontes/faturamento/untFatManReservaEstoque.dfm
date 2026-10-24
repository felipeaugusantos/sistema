inherited frmFatManReservaEstoque: TfrmFatManReservaEstoque
  Width = 970
  Height = 300
  Caption = 
    'Defini'#231#227'o de armaz'#233'm para reserva de estoque de OS - Pedido 9999' +
    '99999999-999'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 970
  ExplicitHeight = 300
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 255
    Width = 964
    ExplicitTop = 255
    ExplicitWidth = 964
    inherited FlwBotoes: TFlowPanel
      Width = 960
      ExplicitWidth = 960
    end
  end
  inherited pnlStatus: TPanel
    Top = 255
    Width = 964
    ExplicitTop = 255
    ExplicitWidth = 964
    inherited pnlNomeForm: TPanel
      Left = 793
      ExplicitLeft = 793
    end
    inherited pnlInfo: TPanel
      Width = 793
      ExplicitWidth = 793
    end
  end
  inherited pgcDados: TPageControl
    Left = 616
    Top = 56
    Width = 105
    Height = 57
    Align = alNone
    Visible = False
    ExplicitLeft = 616
    ExplicitTop = 56
    ExplicitWidth = 105
    ExplicitHeight = 57
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 97
      ExplicitHeight = 25
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 964
    Height = 255
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object dbgGrid: TDBGridCitel
      Left = 0
      Top = 0
      Width = 964
      Height = 226
      Align = alClient
      DataSource = dtsGrid
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnKeyPress = dbgGridKeyPress
      CorZebra = cl3DLight
      Zebra = True
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'CODITE'
          ReadOnly = True
          Title.Caption = 'C'#243'd. Item'
          Width = 58
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESITE'
          ReadOnly = True
          Title.Caption = 'Descri'#231#227'o'
          Width = 270
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QTDITE'
          ReadOnly = True
          Title.Caption = 'Quantidade'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UNIDAD'
          ReadOnly = True
          Title.Caption = 'Un'
          Width = 26
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESMAR'
          ReadOnly = True
          Title.Caption = 'Marca'
          Width = 202
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'REFERE'
          ReadOnly = True
          Title.Caption = 'Refer'#234'ncia'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CODFAB'
          ReadOnly = True
          Title.Caption = 'C'#243'd. F'#225'brica'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NUMLOT'
          Title.Caption = 'Armaz'#233'm'
          Width = 100
          Visible = True
        end>
    end
    object pnlButtons: TPanel
      Left = 0
      Top = 226
      Width = 964
      Height = 29
      Align = alBottom
      Anchors = []
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Color = clGray
      ParentBackground = False
      TabOrder = 1
      object FlwPnlButtons: TFlowPanel
        Left = 2
        Top = 2
        Width = 861
        Height = 25
        Align = alClient
        BevelOuter = bvNone
        ShowCaption = False
        TabOrder = 0
        object btnConfirmar: TBitBtnLocked
          Left = 0
          Top = 0
          Width = 113
          Height = 22
          Caption = '[F10] Confirmar'
          TabOrder = 0
          OnClick = btnConfirmarClick
        end
      end
      object btnFechar: TBitBtnLocked
        AlignWithMargins = True
        Left = 877
        Top = 3
        Width = 82
        Height = 21
        Margins.Left = 14
        Margins.Top = 1
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
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 288
    Top = 40
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 240
    Top = 40
  end
  object dtsGrid: TDataSource
    Left = 336
    Top = 41
  end
end
