inherited frmOpcaoCancelamento: TfrmOpcaoCancelamento
  Width = 691
  Height = 414
  Caption = 'Escolha a Op'#231#227'o de Cancelamento'
  ExplicitWidth = 691
  ExplicitHeight = 414
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 343
    Width = 685
    ExplicitTop = 343
    ExplicitWidth = 685
    inherited FlwBotoes: TFlowPanel
      Width = 681
      ExplicitWidth = 681
      inherited btnConfirma: TBitBtnLocked
        Width = 90
        ExplicitWidth = 90
      end
      object btnRestaurarOpcaoOriginal: TBitBtnLocked
        Left = 90
        Top = 0
        Width = 167
        Height = 22
        Caption = '&Restaurar Op'#231#227'o Original'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000020000
          00080000000C0000000C0000000D0000000D0000000D0000000D0000000D0000
          000D0000000D0000000D0000000D000000080000000200000000000000071B41
          79BF255AA6FF2458A6FF2358A5FF2356A4FF2255A4FF2254A3FF2053A2FF2153
          A2FF2052A1FF2052A1FF2052A1FF173A73BF00000008000000000000000A2860
          ABFF65B9ECFF4CA9E8FF4AA8E7FF47A6E7FF45A5E6FF42A3E6FF40A2E4FF3EA0
          E5FF3C9EE4FF3B9EE3FF54ADE8FF2053A1FF0000000B00000000000000092B65
          AFFF71C1EFFF59B3EAFF57B1EAFF54AFEAFF52ADE9FF4FACE8FF4CA9E8FF4AA8
          E7FF47A6E6FF45A5E6FF5BB2EAFF2255A3FF0000000B00000000000000082E6A
          B2FF7AC7F1FF65BBEDFF63BAEDFF88CFF3FFABE3F8FFC5F1FCFFAAE2F8FF82CA
          F2FF54AFEAFF51ADE9FF65BAECFF2459A6FF0000000A0000000000000007306D
          B5FF81CBF2FF6FC1F0FF90D4F5FFAFE3F6FF74AFDCFF3570B8FF72AEDBFFADE1
          F6FF88CFF2FF5FB7ECFF71C1EEFF275EA9FF0000000900000000000000063270
          B7FFC9F4FDFFC9F4FDFFC9F4FDFF76B0DCFF2A65ADFF235696FF2862ACFF74AF
          DBFFC9F4FDFFC9F4FDFFC9F4FDFF2A62ADFF0000000800000000000000064A96
          D2FFA7EFFEFF2D70B9FF2D70B9FF2A6BB4FF215386FF123C3CFF205082FF2A68
          B0FF2B69B3FF2B69B5FF9FEAFCFF4792CFFF0000000700000000000000054B96
          D4FFA8F0FEFF3074BCFF3071BAFF255B90FF18473CFF4CAD8EFF16453BFF2358
          8DFF2C6EB6FF2D6EB8FFA2EBFDFF4892D0FF0000000600000000000000044B98
          D4FFA8F0FEFFA6EDFBFF88C4CEFF2C5D4DFF53B797FF52D5ADFF52B696FF2A59
          4AFF86C0CCFFA5ECFBFFA5EFFEFF4893D0FF0000000500000000000000023972
          9EBF4C98D4FF4081B4FF1F5350FF52AF91FF59D7B2FF4ED3ABFF57D6B0FF4FAC
          8EFF1D4D4BFF3C7CAEFF4894CFFF366E9CC00000000300000000000000000000
          0002000000060D2D1EA874B29FFFABEFDFFF74E1C1FF52D6AEFF72E0C1FFA8EF
          DCFF72B29EFF0B291BAE0000000B000000030000000100000000000000000000
          0001214E3E8C3D8F72FF3C8E71FF2C7558FF8EE8D0FF86E6CEFF8DE8D0FF2971
          54FF3A8B6EFF3A8A6DFF1F4B3A8F000000020000000000000000000000000000
          00000000000100000002000000052F7B5DFF9EECD9FF86E6CEFF9EECD9FF2C75
          58FF000000080000000500000003000000010000000000000000000000000000
          0000000000000000000000000001337F62FFC0F4E8FFC9F5ECFFBFF4E8FF2F7B
          5EFF000000030000000000000000000000000000000000000000000000000000
          0000000000000000000000000000306F59BE419578FF419477FF409477FF306D
          58BE000000010000000000000000000000000000000000000000}
        TabOrder = 1
        OnClick = btnRestaurarOpcaoOriginalClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 592
      Top = 2
      Width = 90
      ExplicitLeft = 592
      ExplicitTop = 2
      ExplicitWidth = 90
    end
  end
  inherited pnlStatus: TPanel
    Top = 369
    Width = 685
    ExplicitTop = 369
    ExplicitWidth = 685
    inherited pnlNomeForm: TPanel
      Left = 514
      ExplicitLeft = 514
    end
    inherited pnlInfo: TPanel
      Width = 514
      ExplicitWidth = 514
    end
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 0
    Width = 685
    Height = 343
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 2
    object lsbEspecies: TListBox
      Left = 1
      Top = 1
      Width = 683
      Height = 306
      Align = alClient
      Color = 16776176
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemHeight = 17
      ParentFont = False
      TabOrder = 0
      OnClick = lsbEspeciesClick
      OnDblClick = lsbEspeciesDblClick
      OnKeyDown = lsbEspeciesKeyDown
    end
    object Panel1: TPanel
      Left = 1
      Top = 307
      Width = 683
      Height = 35
      Align = alBottom
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label1: TLabel
        Left = 24
        Top = 8
        Width = 84
        Height = 16
        Caption = 'Selecionado:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblSelecionado: TLabel
        Left = 120
        Top = 8
        Width = 505
        Height = 16
        AutoSize = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 360
    Top = 96
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 200
    Top = 152
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 72
    Top = 112
  end
end
