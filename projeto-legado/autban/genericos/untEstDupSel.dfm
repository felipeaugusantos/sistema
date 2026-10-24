inherited frmEstDupSel: TfrmEstDupSel
  Left = 278
  Top = 229
  Height = 567
  BorderIcons = [biSystemMenu]
  Caption = 'frmEstDupSel'
  ExplicitHeight = 567
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 526
    ExplicitTop = 526
    inherited btnSair: TBitBtn
      Left = 600
      Top = 10
      ExplicitLeft = 600
      ExplicitTop = 10
    end
  end
  inherited pnlStatus: TPanel
    Top = 526
    ExplicitTop = 526
  end
  inherited pgcDados: TPageControl
    Height = 526
    ExplicitHeight = 526
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 760
      ExplicitHeight = 494
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 768
    Height = 526
    Align = alClient
    TabOrder = 3
    object pnlDadosDup: TPanel
      Left = 401
      Top = 23
      Width = 366
      Height = 469
      Align = alRight
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      object Label5: TLabel
        Left = 20
        Top = 22
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Nome: TLabel
        Left = 25
        Top = 42
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 11
        Top = 64
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Portador:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 25
        Top = 84
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 3
        Top = 107
        Width = 54
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nosso Nro:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 12
        Top = 128
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Hist'#243'rico:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblProtesta: TLabel
        Left = 12
        Top = 171
        Width = 43
        Height = 14
        Alignment = taRightJustify
        Caption = 'Protesta:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtCodCliBai: TEdit
        Left = 61
        Top = 20
        Width = 284
        Height = 19
        AutoSize = False
        Enabled = False
        TabOrder = 0
      end
      object edtNomCliBai: TEdit
        Left = 61
        Top = 41
        Width = 284
        Height = 19
        AutoSize = False
        Enabled = False
        TabOrder = 1
      end
      object edtCodPorBai: TEdit
        Left = 61
        Top = 62
        Width = 284
        Height = 19
        AutoSize = False
        Enabled = False
        TabOrder = 2
      end
      object edtNomPorBai: TEdit
        Left = 61
        Top = 83
        Width = 284
        Height = 19
        AutoSize = False
        Enabled = False
        TabOrder = 3
      end
      object edtNosNum: TEdit
        Left = 61
        Top = 104
        Width = 284
        Height = 19
        AutoSize = False
        Enabled = False
        TabOrder = 4
      end
      object edtHistor: TEdit
        Left = 61
        Top = 125
        Width = 284
        Height = 19
        AutoSize = False
        Enabled = False
        TabOrder = 5
      end
      object edtHistor2: TEdit
        Left = 61
        Top = 146
        Width = 284
        Height = 19
        AutoSize = False
        Enabled = False
        TabOrder = 6
      end
      object edtDesProtesta: TEdit
        Left = 61
        Top = 167
        Width = 284
        Height = 19
        AutoSize = False
        Enabled = False
        TabOrder = 7
      end
    end
    object pnlTopo: TPanel
      Left = 1
      Top = 1
      Width = 766
      Height = 22
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Caption = 'Sele'#231#227'o de Duplicatas para Cancelamento'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 17
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object Panel2: TPanel
      Left = 1
      Top = 492
      Width = 766
      Height = 33
      Align = alBottom
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Color = clGray
      TabOrder = 2
      DesignSize = (
        766
        33)
      object btnSai: TBitBtn
        Left = 623
        Top = 5
        Width = 142
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[Esc] Sair'
        TabOrder = 3
        OnClick = btnSairClick
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
      end
      object btnSelTodos: TBitBtn
        Left = 4
        Top = 4
        Width = 140
        Height = 23
        Caption = '[ F5 ] Seleciona Todas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnSelTodosClick
      end
      object btnConfirma: TBitBtn
        Left = 291
        Top = 4
        Width = 140
        Height = 23
        Caption = '[ F10 ] Confirma'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = btnConfirmaClick
      end
      object btnDesTodos: TBitBtn
        Left = 147
        Top = 4
        Width = 140
        Height = 23
        Caption = '[ F6 ] Deseleciona Todas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = btnDesTodosClick
      end
    end
    object pnlAux2: TPanel
      Left = 1
      Top = 23
      Width = 400
      Height = 469
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 3
      object pnlTotais: TPanel
        Left = 0
        Top = 408
        Width = 400
        Height = 61
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        TabOrder = 1
        object Label21: TLabel
          Left = 19
          Top = 14
          Width = 96
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Total duplicatas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label9: TLabel
          Left = 12
          Top = 35
          Width = 103
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Total Selecionado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtTotalDup: TEdit
          Left = 125
          Top = 12
          Width = 121
          Height = 19
          AutoSize = False
          Enabled = False
          TabOrder = 0
        end
        object edtTotalSelecionado: TEdit
          Left = 125
          Top = 33
          Width = 121
          Height = 19
          AutoSize = False
          Enabled = False
          TabOrder = 1
        end
      end
      object dbgDuplicatas: TDBGridCitel
        Left = 0
        Top = 0
        Width = 400
        Height = 408
        Align = alClient
        DataSource = frmModuloSPR.dtsTemporaria
        FixedColor = 16770261
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnCellClick = dbgDuplicatasCellClick
        OnDrawDataCell = dbgDuplicatasDrawDataCell
        OnDrawColumnCell = dbgDuplicatasDrawColumnCell
        OnDblClick = dbgDuplicatasDblClick
        OnKeyDown = dbgDuplicatasKeyDown
        OnKeyUp = dbgDuplicatasKeyUp
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'CBI_NUMDUP'
            Title.Alignment = taCenter
            Title.Caption = 'Duplicata'
            Width = 90
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'CBI_ESPDOC'
            Title.Alignment = taCenter
            Title.Caption = 'Esp'#233'cie'
            Width = 50
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'CBI_CODEMP'
            Title.Alignment = taCenter
            Title.Caption = 'Empresa'
            Width = 55
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'CBI_DTAVEN'
            Title.Alignment = taCenter
            Title.Caption = 'Vencimento'
            Width = 85
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'CBI_VALDUP'
            Title.Alignment = taCenter
            Title.Caption = 'Valor'
            Width = 90
            Visible = True
          end>
      end
    end
  end
end
