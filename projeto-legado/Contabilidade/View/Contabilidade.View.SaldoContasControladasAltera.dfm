inherited frmSaldoContasControladasAltera: TfrmSaldoContasControladasAltera
  Width = 760
  Height = 332
  Caption = 'Saldo Contas Controladas'
  Position = poMainFormCenter
  ExplicitWidth = 760
  ExplicitHeight = 332
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 259
    Width = 754
    TabOrder = 6
    ExplicitTop = 275
    ExplicitWidth = 794
    inherited FlwBotoes: TFlowPanel
      Width = 750
      ExplicitWidth = 790
      object btnConfirmar: TcxButton
        Left = 0
        Top = 0
        Width = 105
        Height = 22
        Caption = 'Confirmar'
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          6100000021744558745469746C65004170706C793B4F4B3B436865636B3B4261
          72733B526962626F6E3B6463C8680000037D49444154785E4D8E7F4C94051CC6
          3FEF7B77E02073EA92742577579B684891E62AB6C4526B6013696BC9DC5A0B33
          D0322DA716D3CA94A21A8E96E976AEB654688E409B46B859CC249500E3F81588
          234EE0F875DC1DF7A3BB7BDFF7DBC16AEBD9F3D9BEFF3CCFF7C13555CB58A801
          40014CC5E5696BF638D24FBEF7EDF2D683550F7B0E5666B4969C5A5EBBEBCB65
          2F0209803A116E6438F82377A66A60385007A0E4EFB2A5BC51B1B4AEF4EC5AB9
          D476583A87AA642C7055BA47CE4A43F72752713157F67D93DE54B0DFBE04308D
          867E9E290050725F4BBDB7F8E8B29EAA86B7C4E5BF203DDEE3D23E71585AC6F6
          48E7E4C7D2E777C870A05E7E68DE277B4F668C6EDE6BCF00D4017F350A607EF5
          48DAB99CECBC9CF4343BC3E1264CAA60C282AAA8288A028A30313E852DE509EE
          0C4D72EEF26967CD17FD4F0EDE0A064DF9BBEDEB6CD6C51F3C9DF5382EFF1540
          104014216E500C2ED6DDA4F67C3BEDB79BC9C95EC3E8F8784AD28288BBADC1D3
          6C4E98652A7C2C7D2543816674430304C4885B0755E1CC99EBCC51D750F14E35
          DBCB32E91DF98DCCA5ABE8FCB36733E0500D3132EF9EAB108C7AE9ED1BA6B4AC
          969F2E39896A11CE5F68212529975D5B4A395A59C40B79CF6049D0489AAD81AA
          3C0A9854436741140FE148809AEA16CA8AAEA34C65F1E9E7F524EBEBD99A7F80
          53751FB2707118EB836642311F31C63174497C286BEE6C55D3F48971DF2088C1
          A60D6BF9BAB6849D0547D8FD520D2F3F5F822FD8C7AFCEEF58B16A11FEC82831
          3DC6A87F8868C488745C9D0C9AF5A8D2E51EF15BE72FD248B127E2F5FE8DE3FB
          FDEC28280755E1FDCFB691BF310B6FC48566C4C030F08D458984B40E4057837E
          ADAAA7CB87A0E2090EB2E491594C1A4DD45C2EC779AB0E53B287C4399384A353
          718288A8F4767B09F8F4F380069094BBDD7AB3E474869CB8B1428E5DCB90AAB6
          0DB2E59055B2B621C72EAF93134D99723C8EE3F79572A83A5336EEB439EF9A67
          990FA82A1071F7855EF9E35AC0D3EB0C010A9EF000799B56F1EEDBAFC7BF87D0
          0D411185BEEE30AD8DFE88AB2B501CF0C4FC5706DE34CC0D7F15E9AB53BF6A17
          784ED78C4AB72BF6803DDD82B6B013D5A420064CB875FABB628CB8A21DEEDBA1
          A2D6FAB11B8066480C7EE92F045000737CD6BCA736DFB77F7D616A63EE769BCC
          B0C326CF6E4D6D5B5D70FF47C9732CF700164099CE4D3373FCA76CAB43052CFF
          62065440001D884E130F19FC4FFF00FE20CB5D5DF1FFF30000000049454E44AE
          426082}
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 647
      Width = 105
      ExplicitLeft = 687
      ExplicitWidth = 105
    end
  end
  inherited pnlStatus: TPanel
    Top = 287
    Width = 754
    TabOrder = 7
    ExplicitTop = 303
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 583
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 583
      ExplicitWidth = 623
    end
  end
  object edtSAL_DTALAN: TcxDateEdit [2]
    Left = 96
    Top = 10
    TabOrder = 0
    Width = 121
  end
  object edtSAL_CREDEB: TcxComboBox [3]
    Left = 219
    Top = 161
    Properties.DropDownListStyle = lsEditFixedList
    Properties.Items.Strings = (
      'C'
      'D')
    TabOrder = 4
    Text = 'C'
    Width = 34
  end
  object gbAjusteLucroLiquido: TcxGroupBox [4]
    Left = 4
    Top = 189
    Alignment = alCenterCenter
    TabOrder = 5
    Height = 62
    Width = 741
    object edtSAL_AJLUCR: TcxCheckBox
      Left = 2
      Top = 2
      Align = alTop
      Caption = 'Ajustar Lucro Liquido'
      Properties.OnEditValueChanged = edtSAL_AJLUCRPropertiesEditValueChanged
      TabOrder = 0
      ExplicitWidth = 645
    end
    object cxLabel5: TcxLabel
      Left = 4
      Top = 31
      Caption = 'Natureza Ajuste:'
    end
    object edtSAL_NATAJU: TEditFocus
      Tag = 99
      Left = 92
      Top = 30
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 6
      TabOrder = 1
      OnKeyPress = edtSAL_NATAJUKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNAT_DESCRI: TEditFocus
      Left = 175
      Top = 30
      Width = 564
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object cxLabel1: TcxLabel [5]
    Left = 8
    Top = 14
    Caption = 'Data:'
  end
  object cxLabel2: TcxLabel [6]
    Left = 8
    Top = 42
    Caption = 'Hist'#243'rico Padr'#227'o:'
  end
  object cxLabel3: TcxLabel [7]
    Left = 8
    Top = 66
    Caption = 'Complemento:'
  end
  object cxLabel4: TcxLabel [8]
    Left = 8
    Top = 165
    Caption = 'Valor:'
  end
  object edtSAL_HISPAD: TEditFocus [9]
    Tag = 99
    Left = 96
    Top = 38
    Width = 84
    Height = 22
    Alignment = taLeftJustify
    MaxLength = 3
    TabOrder = 1
    OnKeyPress = edtSAL_HISPADKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtSAL_DESPAD: TEditFocus [10]
    Left = 182
    Top = 38
    Width = 564
    Height = 22
    Alignment = taLeftJustify
    Enabled = False
    TabOrder = 12
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtSAL_HISTOR: TMemoFocus [11]
    Left = 96
    Top = 66
    Width = 650
    Height = 89
    CharCase = ecUpperCase
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    StringQuebra = '<<csq>>'
  end
  object edtSAL_VALLAN: TCurrencyEditFocus [12]
    Left = 96
    Top = 161
    Properties.DisplayFormat = ' ,0.00;- ,0.00'
    StyleFocused.Color = clInfoBk
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    Width = 121
  end
end
