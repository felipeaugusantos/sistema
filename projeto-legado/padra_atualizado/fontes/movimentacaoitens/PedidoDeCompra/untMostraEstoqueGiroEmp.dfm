inherited frmMostraEstoqueGiroEmp: TfrmMostraEstoqueGiroEmp
  Left = 219
  Top = 316
  Width = 800
  Height = 454
  Caption = 'Estoque e Giro nas Empresas'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 800
  ExplicitHeight = 454
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 381
    Width = 794
    ExplicitTop = 381
    ExplicitWidth = 794
    inherited FlwBotoes: TFlowPanel
      Width = 790
      ExplicitWidth = 790
      object btnCfgGri: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 121
        Height = 22
        Caption = 'Confi&gura colunas'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000010000000A09070663583F36EC573D35EC1911105A000000020000
          00090000000E0000000F00000010000000100000001100000011000000110000
          00130000001A0E0A09745D4C44FEC8A995FFC9A996FF553C34E900000008815A
          4EC0B37E6CFFB37D6AFFB37E6CFFB27D6BFFB27C69FFB17D6AFFBE9081FFD1B6
          ADFF947E77FF6D594FFFD6B6A1FFD4B6A1FFDBC7B9FF584037EC0000000CB581
          6FFFFDFBF9FFFBF5F2FFF9F4F0FFF5EFEBFFF1EBE7FFEEE7E3FFECE4E0FFADA2
          9DFF79645AFFD8BBAAFFD8BBA8FFE6D4C7FF8C766CFE1D15125D0000000CB884
          71FFFDFBFAFFF5EBE4FFEBE1DAFFA29089FF6A534BFF4B332BFF574239FF856F
          64FFDCC1B2FFDCC2B0FFEAD7CCFF978177FF2219166F000000080000000BB886
          75FFFCFAFAFFEAE1DBFF816A61FF937A6FFFBFA99CFFDEC8BAFFC7B0A2FFE0C8
          B8FFDFC7B7FFE9DACFFF9B857BFFA88F87FF00000018000000010000000ABA89
          78FFFAF8F7FFAC9A92FFA08A80FFEEE1D9FFF5EDE7FFF0E4DBFFE9D6C8FFE2CC
          BDFFE2CEBFFFA08A80FFBEB1ABFFD6BBB3FF000000110000000000000009BD8C
          7AFFF8F7F6FF8E7368FFC8B6ADFFB4A098FF8F766AFFB09C93FFD8C8BFFFE5CE
          BFFFD1B9ABFF82675DFFEFE9E5FFC4998AFF0000000F0000000000000009C08F
          7FFFF8F7F6FF8C7165FFB7A299FFBFAFA7FFEEE6E1FFBBAAA1FFAF9B92FFE6D1
          C3FFE6D2C7FF7E6459FFF2EDE9FFBB8A77FF0000000E0000000000000008C394
          84FFFAFAF9FF9D867BFFC7B8B0FFF6F0EAFFF8F1ECFFEAE1DCFF71574DFFE7D4
          C6FFD2C0B8FF8C7369FFF5F0EDFFBC8D7AFF0000000D0000000000000007C597
          87FFFDFDFCFFF8F3EEFFF9F3EFFFFAF4EFFFF7F0ECFFA89791FF937C72FFEEE0
          D8FFB09C92FFB9A8A0FFF9F4F1FFC08F7EFF0000000D0000000000000006C79A
          8CFFFEFEFEFFFAF6F3FFFAF5F3FFF9F4F0FFAB9B93FF8F7A72FFCABAB2FFB6A2
          97FFA38C81FFF4ECE8FFFCF8F6FFC39282FF0000000C0000000000000006CA9E
          8EFFFFFEFEFFFBF7F4FFFBF6F4FFF9F4F2FFAC9589FF987D6FFFA58E85FFC6B6
          AFFFF6EFEAFFF9F4EFFFFDFAF8FFC49687FF0000000B0000000000000005CCA3
          91FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFAF5F3FFF8F3F1FFF8F3F1FFFAF4
          F1FFFCF6F2FFFBF6F1FFFDFBF9FFC79A8BFF0000000A0000000000000004CEA4
          95FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
          FDFFFEFDFDFFFEFDFDFFFEFDFCFFC99E8EFF0000000900000000000000029A7B
          6FC0CFA696FFCFA696FFCEA695FFCEA595FFCEA595FFCFA494FFCDA494FFCEA3
          93FFCCA293FFCDA292FFCBA292FF97776BC20000000600000000}
        TabOrder = 0
        OnClick = btnCfgGriClick
      end
      object BitBtnLocked2: TBitBtnLocked
        Left = 121
        Top = 0
        Width = 126
        Height = 22
        Caption = 'Ajustar Colunas'
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
        TabOrder = 1
        OnClick = BitBtnLocked2Click
      end
      object btnPreparacaoTE: TBitBtnLocked
        Left = 247
        Top = 0
        Width = 150
        Height = 22
        Caption = '[F5] - Prepara'#231#227'o para TE '
        TabOrder = 2
        OnClick = btnPreparacaoTEClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 711
      ExplicitLeft = 711
    end
  end
  inherited pnlStatus: TPanel
    Top = 409
    Width = 794
    ExplicitTop = 409
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
  object pnlGiroMeses: TPanel [2]
    Left = 0
    Top = 335
    Width = 794
    Height = 46
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 2
    Visible = False
    object lblQtdM04: TLabel
      Left = 7
      Top = 4
      Width = 47
      Height = 14
      Caption = 'lblQtdM04'
      Visible = False
    end
    object lblQtdM05: TLabel
      Left = 87
      Top = 4
      Width = 47
      Height = 14
      Caption = 'lblQtdM05'
      Visible = False
    end
    object lblQtdM06: TLabel
      Left = 167
      Top = 4
      Width = 47
      Height = 14
      Caption = 'lblQtdM06'
      Visible = False
    end
    object lblQtdM07: TLabel
      Left = 247
      Top = 4
      Width = 47
      Height = 14
      Caption = 'lblQtdM07'
      Visible = False
    end
    object lblQtdM08: TLabel
      Left = 327
      Top = 4
      Width = 47
      Height = 14
      Caption = 'lblQtdM08'
      Visible = False
    end
    object lblQtdM09: TLabel
      Left = 407
      Top = 4
      Width = 47
      Height = 14
      Caption = 'lblQtdM09'
      Visible = False
    end
    object lblQtdM10: TLabel
      Left = 487
      Top = 4
      Width = 47
      Height = 14
      Caption = 'lblQtdM10'
      Visible = False
    end
    object lblQtdM11: TLabel
      Left = 567
      Top = 4
      Width = 46
      Height = 14
      Caption = 'lblQtdM11'
      Visible = False
    end
    object lblQtdM12: TLabel
      Left = 647
      Top = 4
      Width = 47
      Height = 14
      Caption = 'lblQtdM12'
      Visible = False
    end
    object dbeQtdM04: TDBEditFocus
      Left = 7
      Top = 17
      Width = 73
      Height = 22
      DataField = 'MES004'
      TabOrder = 0
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdM05: TDBEditFocus
      Left = 87
      Top = 17
      Width = 73
      Height = 22
      DataField = 'MES005'
      TabOrder = 1
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdM06: TDBEditFocus
      Left = 167
      Top = 17
      Width = 73
      Height = 22
      DataField = 'MES006'
      TabOrder = 2
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdM07: TDBEditFocus
      Left = 247
      Top = 17
      Width = 73
      Height = 22
      DataField = 'MES007'
      TabOrder = 3
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdM08: TDBEditFocus
      Left = 327
      Top = 17
      Width = 73
      Height = 22
      DataField = 'MES008'
      TabOrder = 4
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdM09: TDBEditFocus
      Left = 407
      Top = 17
      Width = 73
      Height = 22
      DataField = 'MES009'
      TabOrder = 5
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdM10: TDBEditFocus
      Left = 487
      Top = 17
      Width = 73
      Height = 22
      DataField = 'MES010'
      TabOrder = 6
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdM11: TDBEditFocus
      Left = 567
      Top = 17
      Width = 73
      Height = 22
      DataField = 'MES011'
      TabOrder = 7
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdM12: TDBEditFocus
      Left = 647
      Top = 17
      Width = 73
      Height = 22
      DataField = 'MES012'
      TabOrder = 8
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object Panel2: TPanel [3]
    Left = 0
    Top = 0
    Width = 794
    Height = 335
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 3
    object pnlCabecalho: TPanel
      Left = 0
      Top = 0
      Width = 794
      Height = 37
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      object Label1: TLabel
        Left = 15
        Top = 15
        Width = 28
        Height = 14
        Caption = 'Item:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtItem: TEditFocus
        Left = 55
        Top = 8
        Width = 682
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object cxgEstoque: TcxGrid
      Left = 0
      Top = 37
      Width = 794
      Height = 298
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxvEstoque: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '0.00'
            Kind = skSum
            Column = cxvEstoqueMES001
          end
          item
            Format = '0.00'
            Kind = skSum
            Column = cxvEstoqueMES002
          end
          item
            Format = '0.00'
            Kind = skSum
            Column = cxvEstoqueMES003
          end
          item
            Format = '0.00'
            Kind = skSum
            Column = cxvEstoqueMEDIA
          end
          item
            Format = '0.00'
            Kind = skSum
            Column = cxvEstoqueSALDOS
          end
          item
            Format = '0.00'
            Kind = skSum
            Column = cxvEstoqueENTFUT
          end
          item
            Format = '0.00'
            Kind = skSum
            Column = cxvEstoqueMESATU
          end
          item
            Format = '0.00'
            Kind = skSum
            Column = cxvEstoqueSALDIS
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        object cxvEstoqueCODEMP: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'CODEMP'
          Options.Moving = False
        end
        object cxvEstoqueNOMEMP: TcxGridDBColumn
          Caption = 'Nome da Empresa'
          DataBinding.FieldName = 'NOMEMP'
          Options.Moving = False
        end
        object cxvEstoqueMESATU: TcxGridDBColumn
          Caption = 'M'#234's Atual'
          DataBinding.FieldName = 'MESATU'
          Options.Moving = False
        end
        object cxvEstoqueMES001: TcxGridDBColumn
          Caption = 'M'#234's 1'
          DataBinding.FieldName = 'MES001'
          Options.Moving = False
        end
        object cxvEstoqueMES002: TcxGridDBColumn
          Caption = 'M'#234's 2'
          DataBinding.FieldName = 'MES002'
          Options.Moving = False
        end
        object cxvEstoqueMES003: TcxGridDBColumn
          Caption = 'M'#234's 3'
          DataBinding.FieldName = 'MES003'
          Options.Moving = False
        end
        object cxvEstoqueMEDIA: TcxGridDBColumn
          Caption = 'M'#233'dia'
          DataBinding.FieldName = 'MEDIA'
          Options.Moving = False
        end
        object cxvEstoqueSALDOS: TcxGridDBColumn
          Caption = 'Saldo Fisico'
          DataBinding.FieldName = 'SALDOS'
          Options.Moving = False
        end
        object cxvEstoqueSALDIS: TcxGridDBColumn
          Caption = 'Saldo Dispon'#237'vel'
          DataBinding.FieldName = 'SALDIS'
          Options.Moving = False
        end
        object cxvEstoqueENTFUT: TcxGridDBColumn
          Caption = 'Ent. Fut.'
          DataBinding.FieldName = 'ENTFUT'
          Options.Moving = False
        end
      end
      object cxgEstoqueLevel1: TcxGridLevel
        GridView = cxvEstoque
      end
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 200
    Top = 192
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Top = 88
  end
end
