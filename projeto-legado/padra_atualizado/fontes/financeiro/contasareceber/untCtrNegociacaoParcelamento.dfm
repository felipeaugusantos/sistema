inherited frmCtrNegociacaoParcelamento: TfrmCtrNegociacaoParcelamento
  Left = 145
  Top = 234
  Width = 739
  Height = 676
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 
    'Contas a Receber - Acerto de Conta - Digita'#231#227'o de Negocia'#231#227'o de ' +
    'Parcelamento'
  Position = poMainFormCenter
  ExplicitWidth = 739
  ExplicitHeight = 676
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 583
    Width = 733
    Height = 48
    TabOrder = 1
    ExplicitTop = 583
    ExplicitWidth = 733
    ExplicitHeight = 48
    DesignSize = (
      733
      48)
    inherited FlwBotoes: TFlowPanel
      Width = 729
      Height = 44
      TabOrder = 1
      ExplicitWidth = 729
      ExplicitHeight = 44
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 164
        Height = 22
        Caption = '[ F10 ] &Gerar Parcelamento'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
          7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF313131726E726A66697D797A2929293838384242422828286868683131
          31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
          6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
          CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
          203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
          A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
          E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
          D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
          ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
          FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
          2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
          5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
          DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
          D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
          C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnAlterarVencimento: TBitBtnLocked
        Left = 164
        Top = 0
        Width = 177
        Height = 22
        Caption = '[ F2 ] &Alterar vencimento'
        Enabled = False
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          20000000000000040000000000000000000000000000000000000000000A0000
          0010000000110000001100000011000000120000001200000012000000120000
          0012000000120000001300000013000000120000000C0000000381594CC2B47C
          69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB27A68FFB37968FFB279
          68FFB27967FFB27867FFB17867FFB17866FF7F5649C30000000BB77F6EFFFBF8
          F5FFF8EEE9FFF8EEE9FFF7EFE8FFF7EEE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7ED
          E6FFF6EDE6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF00000011B98472FFFBF8
          F6FFBF998AFFEBDAD3FFBE9788FFEBDAD3FFBD9586FFEBDAD3FFBC9484FFEBDA
          D3FF5D6DDDFFE4DDE1FF5A69DCFFF7EDE7FFB77F6EFF00000011BC8978FFFCFA
          F8FFEBDDD5FFECDCD5FFEBDDD5FFECDCD5FFEBDDD5FFECDCD5FFEBDDD5FFECDC
          D5FFE5DFE3FFE5DFE2FFE5DEE2FFF8EEE9FFB98472FF00000010C08E7DFFFCFA
          F9FFC6A294FFEDDED6FFC4A092FFEDDED6FFC29E8EFFEDDED6FFC19B8CFFEDDE
          D6FF6577E1FFE5E0E4FF6272E0FFF8F1EBFFBC8977FF00000010C39482FFFCFA
          FAFFEDDFD9FFEDDFD8FFEDDFD9FFEDDFD8FFEDDFD9FFEDDFD8FFEDDFD9FFEDDF
          D8FFE6E2E6FFE6E2E6FFE6E2E5FFF9F2EEFFC08E7CFF0000000FC79887FFFDFB
          FAFFCCAB9DFFEEE0DBFFCAA99BFFEEE0DBFFC9A799FFEEE0DBFFC8A496FFEEE0
          DBFF6D81E5FFE8E3E8FF6A7DE4FFFAF4F0FFC49381FF0000000EC99D8CFFFDFC
          FCFFEEE2DCFFEEE2DCFFEEE2DCFFEEE2DCFFEEE2DCFFEEE2DCFFEEE2DCFFEEE2
          DCFFE8E6EAFFE8E5EAFFE8E4E9FFFAF6F2FFC69886FF0000000DCDA190FFFEFC
          FCFFD0B1A3FFEFE3DFFFCFB0A2FFEFE3DFFFCFAFA0FFEFE3DFFFCDAD9FFFEFE3
          DFFF7388E8FFE9E6EBFF7186E7FFFBF7F5FFC99D8BFF0000000DCFA594FFFEFC
          FCFFFDF9F9FFFDF9F9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9
          F7FFFCF9F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C4B53C3FF8D9E
          ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5F70DFFF5D6CDEFF5B69
          DCFF5966DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B4C55C4FF93A4
          EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6375E1FF6172E0FF5E6F
          DEFF5C6CDDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A4D56C6FF96A7
          EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8B9BEBFF8898EAFF8595
          EAFF8291E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF000000093A4093C14D55
          C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF444BBBFF4249B9FF4046
          B7FF3E44B4FF3C41B3FF3A3EB0FF393CAEFF282B80C200000006000000040000
          0006000000060000000600000007000000070000000700000007000000070000
          0007000000070000000800000008000000070000000500000001}
        TabOrder = 1
        OnClick = btnAlterarVencimentoClick
      end
      object btnCopiar: TBitBtnLocked
        Left = 341
        Top = 0
        Width = 221
        Height = 22
        Caption = '[ F3 ] &Copiar para '#225'rea de transfer'#234'ncia'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0002000000090000000E0000000F0000000F0000001000000010000000110000
          0011000000100000000B00000003000000000000000000000000000000000000
          00087C5345C0AD725EFFAC725DFFAC715DFFAC6F5BFFAB705CFFAB705CFFAB6E
          5CFFAB6E5AFF7A4E41C30000000B000000000000000000000000000000000000
          000BAF7462FFFDFBF9FFFBF6F2FFFBF5F2FFFAF5F1FFFBF4EFFFF9F3EEFFF9F2
          EEFFFAF2ECFFAC715DFF0000000F000000000000000000000000000000000000
          000BB17964FFFDFBFAFFF7EEE7FFF8EDE7FFF7EDE7FFF7EDE6FFF6ECE5FFF6EC
          E5FFFAF2EEFFAE7260FF01010120010101100101010B00000003000000000000
          000BB37C69FFFDFCFBFFF8EFE8FFF7EEE8FFF7EEE8FFF8EEE7FFF7EEE7FFF7EC
          E6FFFAF3EFFFB07863FFC19D92FFB57D6AFF815A4EC30101010B000000000000
          000AB57F6CFFFEFCFBFFF9F0EAFFF8F0EAFFF8EFE9FFF8EFE8FFF8EEE9FFF8EE
          E7FFFBF5F1FFB27A66FFEBE6E2FFFAF3EDFFB6806DFF0101010F000000000000
          0009B98270FFFEFDFCFFF9F2EDFFF9F2EDFFF9F0EBFFF9F0EAFFF8F0EAFFF8F0
          E9FFFBF6F3FFB37D6AFFE9E1DAFFFAF3EFFFB88170FF01010110000000000000
          0008BB8775FFFEFDFDFFFAF3EFFFFAF4EEFFFAF3EEFFFAF1ECFFF9F1EBFFF9F0
          EBFFFCF8F5FFB6806DFFEAE1DBFFFAF4F0FFB98673FF0101010F000000000000
          0007BF8B78FFFEFEFDFFFBF5F1FFFBF5F0FFFBF4F0FFFAF3EFFFFAF3EFFFF9F3
          EDFFFCF9F7FFBA8471FFECE4DDFFFBF5F2FFBB8876FF0101010E000000000000
          0007C18E7EFFFEFEFDFFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4
          EFFFFDFAF8FFBC8978FFEDE7E0FFFBF6F4FFBC8B7AFF0101010D000000000000
          0006C49382FFFEFEFEFFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5
          F1FFFDFBF9FFBF8C7CFFEFE8E3FFFCF8F5FFBF8E7CFF0101010D000000000000
          0005C49785FFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFDFDFFFEFD
          FDFFFEFDFCFFC2907FFFF0EBE6FFFCF9F7FFC29180FF0101010C000000000000
          0003967265C0C89988FFC99887FFC79887FFC59786FFC79785FFC79784FFC596
          84FFC59683FFCDA79AFFF4EFEAFFFDFAF8FFC49686FF0101010B000000000000
          000100000003000000040000000BD8BBB0FFF8F8F8FFF5F0EFFFF5F0EFFFF5EF
          EDFFF5EFEDFFF7F0EEFFFAF4F1FFFDFBF9FFC7998AFF0000000A000000000000
          0000000000000000000000000005CCA392FFFFFEFEFFFEFEFEFFFEFEFEFFFEFE
          FEFFFEFEFDFFFEFDFDFFFEFDFDFFFEFDFCFFCA9D8DFF00000009000000000000
          00000000000000000000000000039A7B6FC0CEA495FFCFA494FFCDA494FFCCA3
          93FFCDA392FFCDA391FFCCA291FFCCA290FF97776BC200000006}
        TabOrder = 2
        OnClick = btnCopiarClick
      end
      object btnRegraAlteracoes: TBitBtnLocked
        Left = 562
        Top = 0
        Width = 153
        Height = 22
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '&Regras'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333FFFFF3333333333F797F3333333333F737373FF333333BFB999BFB
          33333337737773773F3333BFBF797FBFB33333733337333373F33BFBFBFBFBFB
          FB3337F33333F33337F33FBFBFB9BFBFBF3337333337F333373FFBFBFBF97BFB
          FBF37F333337FF33337FBFBFBFB99FBFBFB37F3333377FF3337FFBFBFBFB99FB
          FBF37F33333377FF337FBFBF77BF799FBFB37F333FF3377F337FFBFB99FB799B
          FBF373F377F3377F33733FBF997F799FBF3337F377FFF77337F33BFBF99999FB
          FB33373F37777733373333BFBF999FBFB3333373FF77733F7333333BFBFBFBFB
          3333333773FFFF77333333333FBFBF3333333333377777333333}
        NumGlyphs = 2
        TabOrder = 3
        OnClick = btnRegraAlteracoesClick
      end
      object btnPrevia: TBitBtnLocked
        Left = 0
        Top = 22
        Width = 164
        Height = 22
        Caption = '[ F4 ] &Pr'#233'via da Negocia'#231#227'o'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          6666666666666666666666660000666666666666666666666FFFFFFFFFFFF666
          000066000000000000666666888888888888F666000066877777777770666666
          8F6666666668F6660000668FFFFFFFFF706666668F6FF6FFFF68F6660000668F
          44F4444F706666668F8868888668F6660000668FFFFFFFFF706666668F6FF6FF
          FF68F6660000668F44F4444F706666668F8868888668F6660000668FFFFFFFFF
          706666668F6666666668F6660000668FFFFFFF0F706666668F6FF6668F68F66F
          0000668F00FFF0B0706664668F88FF68F8F8F6F80000668F0F0F0B0F00064466
          8F8F8F8F8F888F880000668FF0B0B0F0FBF044668FF8F8F8F8F6F88800006688
          880F0F0FBFBF446688888F8F86666688000066666660B0FBFBFB4466666668F8
          66666F880000666666660FBFBFB044666666668FFFFFF8880000666666666000
          0006446666666668888886880000666666666666666666666666666666666666
          0000}
        NumGlyphs = 2
        TabOrder = 4
        OnClick = btnPreviaClick
      end
      object btnHelpPrevia: TBitBtnLocked
        Left = 164
        Top = 22
        Width = 31
        Height = 22
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          0800000000000001000000000000000000000001000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A6000020400000206000002080000020A0000020C0000020E000004000000040
          20000040400000406000004080000040A0000040C0000040E000006000000060
          20000060400000606000006080000060A0000060C0000060E000008000000080
          20000080400000806000008080000080A0000080C0000080E00000A0000000A0
          200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
          200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
          200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
          20004000400040006000400080004000A0004000C0004000E000402000004020
          20004020400040206000402080004020A0004020C0004020E000404000004040
          20004040400040406000404080004040A0004040C0004040E000406000004060
          20004060400040606000406080004060A0004060C0004060E000408000004080
          20004080400040806000408080004080A0004080C0004080E00040A0000040A0
          200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
          200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
          200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
          20008000400080006000800080008000A0008000C0008000E000802000008020
          20008020400080206000802080008020A0008020C0008020E000804000008040
          20008040400080406000804080008040A0008040C0008040E000806000008060
          20008060400080606000806080008060A0008060C0008060E000808000008080
          20008080400080806000808080008080A0008080C0008080E00080A0000080A0
          200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
          200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
          200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
          2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
          2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
          2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
          2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
          2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
          2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
          2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          499191480000000000000000000000009AECEB91000000000000000000000000
          E309F49A00000000000000000000000049E3A349000000000000000000000000
          00000000000000000000000000000000009A9949000000000000000000000000
          00A309E2480000000000000000000000009AEC09E29100000000000000005191
          49009A0909EC9100000000000000E309E3499AEC0909DA00000000000000A309
          EC9AA3EC09099A0000000000000049EC09ECEC0909E300000000000000000049
          A3EC09EC9A000000000000000000000000000000000000000000}
        TabOrder = 5
        OnClick = btnHelpPreviaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 564
      Top = 23
      Width = 153
      Anchors = [akLeft, akBottom]
      TabOrder = 0
      ExplicitLeft = 564
      ExplicitTop = 23
      ExplicitWidth = 153
    end
  end
  inherited pnlStatus: TPanel
    Top = 631
    Width = 733
    TabOrder = 2
    ExplicitTop = 631
    ExplicitWidth = 733
    inherited pnlNomeForm: TPanel
      Left = 562
      ExplicitLeft = 562
    end
    inherited pnlInfo: TPanel
      Width = 562
      ExplicitWidth = 562
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 29
    Width = 733
    Height = 308
    Align = alTop
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 38
      Top = 59
      Width = 103
      Height = 14
      Caption = 'Total Geral Corrigido :'
    end
    object Label2: TLabel
      Left = 52
      Top = 132
      Width = 89
      Height = 14
      Caption = 'Qtde de Parcelas :'
    end
    object Label5: TLabel
      Left = 14
      Top = 179
      Width = 127
      Height = 14
      Caption = 'Taxa Juros Parcelamento :'
    end
    object Label8: TLabel
      Left = 244
      Top = 179
      Width = 41
      Height = 14
      Caption = '(%) a.m.'
    end
    object lblCarencia: TLabel
      Left = 24
      Top = 250
      Width = 117
      Height = 14
      Caption = 'Car'#234'ncia (N'#186' Parcelas) :'
    end
    object lblPreVis: TLabel
      Left = 356
      Top = 79
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Base :'
    end
    object Label7: TLabel
      Left = 343
      Top = 154
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Amortiza'#231#227'o :'
    end
    object Label9: TLabel
      Left = 377
      Top = 178
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Juros :'
    end
    object Label10: TLabel
      Left = 354
      Top = 202
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Final :'
    end
    object Label11: TLabel
      Left = 3
      Top = 273
      Width = 517
      Height = 28
      AutoSize = False
      Caption = 
        '** A taxa de juros do parcelamento ser'#225' calculada automaticament' +
        'e caso informe o "Valor Final Desejado".      Se deseja digitar ' +
        'a taxa de juros favor n'#227'o informar valor neste campo.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object Label6: TLabel
      Left = 26
      Top = 155
      Width = 115
      Height = 14
      Caption = '** Valor Final Desejado :'
    end
    object Label3: TLabel
      Left = 41
      Top = 107
      Width = 100
      Height = 14
      Caption = 'Total com Desconto :'
    end
    object Label4: TLabel
      Left = 61
      Top = 83
      Width = 80
      Height = 14
      Caption = 'Valor Desconto :'
    end
    object edtValorCorrigido: TEditFocus
      Tag = 99
      Left = 144
      Top = 53
      Width = 95
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtParcelas: TEditFocus
      Tag = 99
      Left = 144
      Top = 126
      Width = 33
      Height = 22
      Alignment = taCenter
      MaxLength = 3
      TabOrder = 7
      Text = '1'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
    object edtIntervalo: TEditFocus
      Tag = 99
      Left = 144
      Top = 197
      Width = 33
      Height = 22
      Alignment = taCenter
      MaxLength = 3
      TabOrder = 12
      Text = '30'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
    object edtTaxa: TEditFocus
      Tag = 99
      Left = 144
      Top = 173
      Width = 95
      Height = 22
      Alignment = taRightJustify
      TabOrder = 10
      Text = '0,0000'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.0000'
    end
    object edtDiaFixo: TEditFocus
      Tag = 99
      Left = 144
      Top = 221
      Width = 33
      Height = 22
      Alignment = taCenter
      MaxLength = 2
      TabOrder = 16
      Text = '1'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
    object chkIntervalo: TCheckBox
      Tag = 99
      Left = 15
      Top = 202
      Width = 123
      Height = 17
      TabStop = False
      Caption = 'Intervalo em Dias        :'
      TabOrder = 14
      OnClick = chkIntervaloClick
    end
    object chkDiaFixo: TCheckBox
      Tag = 99
      Left = 15
      Top = 226
      Width = 126
      Height = 17
      TabStop = False
      Caption = 'Vencimento Dia Fixo   :'
      TabOrder = 15
      OnClick = chkDiaFixoClick
    end
    object edtCarencia: TEditFocus
      Tag = 99
      Left = 144
      Top = 245
      Width = 33
      Height = 22
      Alignment = taCenter
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 17
      Text = '0'
      OnChange = edtCarenciaChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
    object edtAmortizacao: TEditFocus
      Tag = 99
      Left = 415
      Top = 149
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 9
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtJuros: TEditFocus
      Tag = 99
      Left = 415
      Top = 173
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 11
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtValorFinal: TEditFocus
      Tag = 99
      Left = 415
      Top = 197
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 13
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object btnCalcular: TBitBtnLocked
      Left = 415
      Top = 242
      Width = 84
      Height = 25
      Caption = '&Calcular'
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
      TabOrder = 18
      OnClick = btnCalcularClick
    end
    object chkPrimeiraParc: TCheckBox
      Left = 277
      Top = 53
      Width = 137
      Height = 17
      Caption = 'Primeira parcela '#224' vista :'
      TabOrder = 2
      OnClick = chkPrimeiraParcClick
    end
    object mskDataPrimeiraParc: TMaskEditFocus
      Tag = 99
      Left = 415
      Top = 50
      Width = 90
      Height = 22
      Enabled = False
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtValorDesejado: TEditFocus
      Tag = 99
      Left = 144
      Top = 149
      Width = 95
      Height = 22
      Alignment = taRightJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      Text = '0,00'
      OnChange = edtValorDesejadoChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtValorBase: TEditFocus
      Tag = 99
      Left = 144
      Top = 101
      Width = 95
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDesconto: TEditFocus
      Tag = 99
      Left = 144
      Top = 77
      Width = 95
      Height = 22
      Alignment = taRightJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object mskDataBase: TcxDateEdit
      Tag = 99
      Left = 415
      Top = 74
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000000000020000000A0000
        0010000000110000001100000011000000120000001200000012000000120000
        00120000001300000013000000120000000C000000030000000A81594CC2B47C
        69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
        67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
        F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
        E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
        F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
        83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
        F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
        D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
        F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
        86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
        FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
        D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
        FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
        8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
        FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
        DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
        FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
        91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
        FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
        F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
        ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
        DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
        EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
        DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
        EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
        E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
        C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
        B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
        0006000000060000000600000007000000070000000700000007000000070000
        00070000000800000008000000070000000500000001}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      Style.BorderStyle = ebsUltraFlat
      Style.LookAndFeel.Kind = lfUltraFlat
      StyleDisabled.LookAndFeel.Kind = lfUltraFlat
      StyleFocused.Color = clInfoBk
      StyleFocused.LookAndFeel.Kind = lfUltraFlat
      StyleHot.LookAndFeel.Kind = lfUltraFlat
      TabOrder = 5
      Width = 90
    end
    object rdgOperacao: TRadioGroup
      Left = 15
      Top = 7
      Width = 380
      Height = 38
      Caption = ' Opera'#231#227'o '
      Columns = 2
      Ctl3D = True
      ItemIndex = 0
      Items.Strings = (
        'Manual'
        'Conforme condi'#231#227'o de pagamento')
      ParentCtl3D = False
      TabOrder = 0
      OnClick = rdgOperacaoClick
    end
    object chkDiferencaUltParcela: TCheckBox
      Tag = 99
      Left = 356
      Top = 107
      Width = 181
      Height = 26
      TabStop = False
      Caption = 'Jogar a diferen'#231'a de centavos para a ultima parcela'
      Checked = True
      State = cbChecked
      TabOrder = 19
      WordWrap = True
      OnClick = chkIntervaloClick
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 733
    Height = 29
    Align = alTop
    Caption = 'NEGOCIA'#199#195'O DE PARCELAMENTO'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 4
  end
  object pnlGrid: TPanel [4]
    Left = 0
    Top = 337
    Width = 733
    Height = 246
    Align = alClient
    ParentColor = True
    TabOrder = 3
    object pnlTotais: TPanel
      Left = 1
      Top = 206
      Width = 731
      Height = 39
      Align = alBottom
      BevelInner = bvLowered
      TabOrder = 0
      DesignSize = (
        731
        39)
      object Label13: TLabel
        Left = 537
        Top = 13
        Width = 65
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Total a Pagar:'
      end
      object Label14: TLabel
        Left = 317
        Top = 13
        Width = 77
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total Presta'#231#227'o:'
      end
      object edtValPag: TEditFocus
        Tag = 99
        Left = 608
        Top = 9
        Width = 118
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akLeft, akTop, akRight]
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        Text = '0,00'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtValPre: TEditFocus
        Tag = 99
        Left = 397
        Top = 9
        Width = 110
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        Text = '0,00'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
    object cxGridParcelas: TcxGrid
      Left = 1
      Top = 1
      Width = 731
      Height = 205
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxvGridParcelas: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxvGridParcelasCustomDrawCell
        OnEditing = cxvGridParcelasEditing
        OnEditValueChanged = cxvGridParcelasEditValueChanged
        DataController.DataSource = dtsParcelas
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsSelection.HideSelection = True
        OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
        OptionsView.GroupByBox = False
        Styles.ContentEven = cxStyleZebra
        object cxvGridParcelasColumn1: TcxGridDBColumn
          DataBinding.FieldName = 'parcela'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 57
        end
        object cxvGridParcelasVENCIMENTO: TcxGridDBColumn
          DataBinding.FieldName = 'vencimento'
          PropertiesClassName = 'TcxDateEditProperties'
          Properties.DisplayFormat = 'dd/mm/yyyy'
          Properties.ReadOnly = True
          Properties.SaveTime = False
          Properties.ValidationOptions = [evoShowErrorIcon]
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 83
        end
        object cxvGridParcelasColumn3: TcxGridDBColumn
          DataBinding.FieldName = 'saldo_devedor'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 118
        end
        object cxvGridParcelasColumn4: TcxGridDBColumn
          DataBinding.FieldName = 'amortizacao'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 107
        end
        object cxvGridParcelasColumn5: TcxGridDBColumn
          DataBinding.FieldName = 'juros'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 99
        end
        object cxvGridParcelasColumn6: TcxGridDBColumn
          DataBinding.FieldName = 'prestacao'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 112
        end
        object cxvGridParcelasColumn7: TcxGridDBColumn
          DataBinding.FieldName = 'prestacao_a_pagar'
          HeaderAlignmentHorz = taRightJustify
          Width = 117
        end
      end
      object cxGridParcelasLevel1: TcxGridLevel
        GridView = cxvGridParcelas
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 544
    Top = 224
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 648
    Top = 224
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 608
    Top = 224
  end
  object cdsParcelas: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 224
    Top = 336
    object cdsParcelasparcela: TStringField
      Alignment = taCenter
      DisplayLabel = 'Parcela'
      FieldName = 'parcela'
      Size = 3
    end
    object cdsParcelasvencimento: TDateField
      Alignment = taCenter
      DisplayLabel = 'Vencimento'
      FieldName = 'vencimento'
      OnChange = cdsParcelasvencimentoChange
    end
    object cdsParcelassaldo_devedor: TFloatField
      DisplayLabel = 'Saldo Devedor'
      FieldName = 'saldo_devedor'
      DisplayFormat = '#,##0.00'
    end
    object cdsParcelasamortizacao: TFloatField
      DisplayLabel = 'Amortiza'#231#227'o'
      FieldName = 'amortizacao'
      DisplayFormat = '#,##0.00'
    end
    object cdsParcelasjuros: TFloatField
      DisplayLabel = 'Juros'
      FieldName = 'juros'
      DisplayFormat = '#,##0.00'
    end
    object cdsParcelasprestacao: TFloatField
      DisplayLabel = 'Presta'#231#227'o'
      FieldName = 'prestacao'
      DisplayFormat = '#,##0.00'
    end
    object cdsParcelasprestacao_a_pagar: TFloatField
      DisplayLabel = 'Presta'#231#227'o a Pagar'
      FieldName = 'prestacao_a_pagar'
      OnChange = cdsParcelasprestacao_a_pagarChange
      DisplayFormat = '#,##0.00'
    end
  end
  object dtsParcelas: TDataSource
    DataSet = cdsParcelas
    Left = 296
    Top = 336
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 176
    Top = 464
    PixelsPerInch = 96
    object cxStyleZebra: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
