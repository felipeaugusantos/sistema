inherited frmLotePrecosEfetivacao: TfrmLotePrecosEfetivacao
  Left = 270
  Top = 169
  VertScrollBar.Range = 0
  Caption = 'Ativar lote de pre'#231'os da entrada de mercadorias'
  ClientHeight = 566
  ClientWidth = 756
  Position = poDesigned
  WindowState = wsMaximized
  ExplicitWidth = 772
  ExplicitHeight = 605
  PixelsPerInch = 96
  TextHeight = 14
  object splPrecos: TSplitter [0]
    Left = 0
    Top = 177
    Width = 756
    Height = 2
    Cursor = crVSplit
    Align = alBottom
    AutoSnap = False
    Beveled = True
    MinSize = 20
    ResizeStyle = rsNone
    ExplicitLeft = -44
    ExplicitTop = 272
    ExplicitWidth = 800
  end
  inherited pnlBotoes: TPanel
    Top = 522
    Width = 756
    ExplicitTop = 522
    ExplicitWidth = 756
    DesignSize = (
      756
      28)
    inherited btnSair: TBitBtnLocked
      Left = 634
      Width = 120
      TabOrder = 1
      ExplicitLeft = 634
      ExplicitWidth = 120
    end
    inherited btnPesquisar: TBitBtnLocked
      Left = 263
      Width = 111
      TabOrder = 3
      ExplicitLeft = 263
      ExplicitWidth = 111
    end
    inherited btnMudaOrdem: TBitBtnLocked
      Left = 133
      Width = 130
      TabOrder = 2
      ExplicitLeft = 133
      ExplicitWidth = 130
    end
    object btnConfirma: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 130
      Height = 22
      Caption = '[ F10 ] Confirma'
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
    object btnMarcar: TBitBtnLocked
      Left = 374
      Top = 3
      Width = 124
      Height = 22
      Caption = '[ F6 ] Marcar Todos'
      TabOrder = 4
      OnClick = btnMarcarClick
    end
    object btnDesmarcar: TBitBtnLocked
      Left = 498
      Top = 3
      Width = 136
      Height = 22
      Caption = '[ F7 ] Desmarcar Todos'
      TabOrder = 5
      OnClick = btnDesmarcarClick
    end
  end
  inherited pnlHeader: TPanel
    Width = 756
    Height = 89
    BevelOuter = bvRaised
    ExplicitWidth = 756
    ExplicitHeight = 89
    object Label1: TLabel
      Left = 13
      Top = 39
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object Label2: TLabel
      Left = 17
      Top = 66
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
    end
    object Label3: TLabel
      Left = 168
      Top = 62
      Width = 4
      Height = 14
      Alignment = taRightJustify
      Caption = '-'
    end
    object Label4: TLabel
      Left = 213
      Top = 66
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'S'#233'rie:'
    end
    object Label5: TLabel
      Left = 292
      Top = 66
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data de Entrada:'
    end
    object Label6: TLabel
      Left = 6
      Top = 13
      Width = 66
      Height = 14
      Alignment = taRightJustify
      Caption = 'Respons'#225'vel:'
    end
    object edtCodFor: TEditFocus
      Left = 76
      Top = 33
      Width = 375
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtNumDoc: TEditFocus
      Left = 76
      Top = 59
      Width = 90
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtEspDoc: TEditFocus
      Left = 174
      Top = 59
      Width = 32
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtSerie: TEditFocus
      Left = 243
      Top = 59
      Width = 42
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
    object edtDtaEnt: TEditFocus
      Left = 376
      Top = 59
      Width = 75
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtOpeRes: TEditFocus
      Left = 76
      Top = 7
      Width = 375
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
    object btnPesLot: TBitBtnLocked
      Left = 461
      Top = 50
      Width = 146
      Height = 31
      Caption = '[F1] &Pesquisar Lote'
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FF1C98CE1C98CE1C98CEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF0E90C946B2DA3BB5DE24A4D51698CE0F90CA0C8CC6FF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9975741F4975FF00FFFF00FFFF00FF098AC68FD1EAB4FFFF78F6FF76EE
        FC65DDF34ECAEA3CBAE129A9D81899CF0F90CA0A8BC60A8BC6FF00FFFF00FFFF
        00FFFF01FEFF00FFAC7673235E9C0D6BD15E809FFF00FFFF00FF078AC648ADD7
        D1FFFF79FBFF7DFAFF7FFCFF81FAFF81FAFF7AF3FF75EAFC5FD8F340BFE52DAD
        DA1C9ED11193CB0E8FC9288AB7A978772C5E8E106DE235A3FF3099F0FF00FFFF
        00FF0D8FC91896CCBDEAF68AFEFF7AF7FF7AF7FF79F4FF78F4FF78F4FF78F4FF
        79F4FF7DF4FF78F2FF72EAFC68DEF66BBFD5918388265C8F0D6EE0359EFF3FAA
        FE2392FFFF00FFFF00FF1396CB20A0D36FC2E2ADFFFF76F7FF7AF7FF79F4FF78
        F4FF77F3FF78F0FC77EFFE75EEFE76EFFE74EFFF81DEEA9A8E912D5D8E0D6DDD
        319AFF3DA9FF228EFEFF00FFFF00FFFF00FF1091CA49C1E33BABD7BCF8FC79FB
        FF7AF7FF79F4FF78F4FF83D9E28FCAD08ED7DA87CAD07AC2CB74E3F07FB4BB34
        628B0A6BD8329DFF3EA9FF2899F60D8EC9FF00FFFF00FFFF00FF0F8FC966D8EF
        38BAE0A3DDEF8AFEFF78F4FE7BE9F28BDCE0BBAFA4DDC6ADDAD4B6D3C7ACB8AB
        988FA5A373898B5280A746AAFB3FAFFF32A4FB56D1F61396CBFF00FFFF00FFFF
        00FF0F8FC96EDEF2A4676970C1E1A7FFFF75E9F091A1A3CBCEC4F7F0D0FFFFD7
        FFFFD5FFFFD8FFFFD5D3C49DA78472CAB0A97AD8FA4EC9FE4AC5F66CE5FC2BAD
        D9FF00FFFF00FFFF00FF0F8FC96CDCF0A4676940B0D9C4F8FE7DC7CBCBB0A7FF
        FCF8FFFFF6FFFFDAFFFFD4FFFFD3FFFCCFFFF8BBF2D3A4D5A48E76DAEF6DE7FE
        4ECAF66FE7FF52D0ED0C8CC7FF00FFFF00FF108FC96BDAEFA0675B30B5DDABDA
        EEA79F99F8F6DAFFFFFEFFFFFEFFFFF0FFFFDCFFFFD1FCF6C6FAD89EFFDE9DD5
        B1918AC0C96EE5FB4ECAF66CE3FE73EBFC1698CEFF00FFFF00FF108FC96BDAEF
        A0675BFFF4E5289FD0C4A390FFFFDEFFFFEAFFFFFCFFFFF6FFFFDCFFFFD3FCF7
        C6F0C28AFCCE89EDD1A3A7AAA973DAF04ECAF669E2FB81F7FF33B6DE0A8AC5FF
        00FF1190C972DDF2A7756BFFFBF0F8EADCCBB699FFFFDAFFFFD8FFFFE3FFFFE1
        FFFFD8FFFFD3FAE6B1EBAB72F6C27FF4D9A5B1A7A379D4E64ECAF669E2FB81F7
        FF66E1F71192CAFF00FF1290C973DEF2A7756BFFFFFCFAF0E6CAAB93FFFFD7FF
        FFD4FFFFD5FFFFD8FFFFD5FCF0BFF2C589E9A362FBCF88F2D9A7A6ABA973D8EB
        4BC9F667E2FB7AF3FF7DF4FF28ACD9FF00FF1290C972E0F2BC8268FFFFFFFEF7
        F2B78F84FCFECCFFFFD1FCF8C9FEF7C7FAE5AFF2C78BEEBC82F4D39FFFF7B6E2
        C49CA3BABF8BEAFA62D1F879E7FE88F7FF89F8FF54D0EE0C8EC61290C972E0F2
        BC8268FFFFFFFFFEFCD4BCB7D1B89AFFFFC9FADDA1EFBD86EAAA6EEBB274F7DE
        BAFFFFF8F0E7CEAF9F989CC6D8A0D8EDADDEF0BBE6F3BDEAF6C2EEF8B2E9F718
        96CC1391CA76E2F3D1926DFFFFFFFFFFFFFAF7F6DDC6BBDCBF9AFFEBABFEDD98
        FED58CFFE6A1FFFFE0EDE6E2B8918953B5D041C2E63FC0E61C9ED11190C91593
        CA1895CB1A97CB0F91C91593CA7FE6F4D1926DFFFFFFFFFFFFFFFFFFFEFBF8E7
        D4CBD8AF9AE9C9A0E3C29CE1C49CCAAB8EAF9583A56B6B76EFFF76F3FF74EFFF
        23A9D8FF00FFFF00FFFF00FFFF00FFFF00FF0F8FC988DCEFDA9D75FFFFFFFFFF
        FFFFFFFFFFFFFFFFFEFCFCF6EFFCF3E6EDD8C9A56B5FA56B5FA56B5FA4676983
        E9FC82EBFC80E9FC24A4D5FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF3AA7D5
        DA9D75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFBFFFEF7DAC1BAA56B5FE19E
        55E68F31B56D4D1F9CCF239FD126A0D11192CAFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF0A8CC7E7AB79FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        DCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8
        F2EFF7F2EFF7F2EFD8C2C0A56B5FC1836CFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD192
        6DD1926DD1926DD1926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 6
      OnClick = btnPesLotClick
    end
  end
  inherited pnlTail: TPanel
    Top = 179
    Width = 756
    Height = 343
    Visible = True
    ExplicitTop = 179
    ExplicitWidth = 756
    ExplicitHeight = 343
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 591
      Height = 333
      Align = alClient
      ParentBackground = False
      ParentColor = True
      TabOrder = 0
      object pnlTitPrecos: TPanel
        Left = 1
        Top = 1
        Width = 589
        Height = 20
        Align = alTop
        Caption = 'PRE'#199'OS DO PRODUTO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBackground = False
        ParentColor = True
        ParentFont = False
        TabOrder = 0
      end
      object dbgPrecos: TDBGridCitel
        Left = 1
        Top = 21
        Width = 589
        Height = 311
        Align = alClient
        DataSource = dtsPrecos
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnDrawColumnCell = dbgPrecosDrawColumnCell
        OnEnter = dbgPrecosEnter
        OnKeyDown = dbgPrecosKeyDown
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'DESCRI'
            Title.Caption = 'Descri'#231#227'o'
            Width = 230
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'VALANT'
            Title.Alignment = taRightJustify
            Title.Caption = 'Valor Anterior'
            Width = 120
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'VALATU'
            Title.Alignment = taRightJustify
            Title.Caption = 'Valor Atual'
            Width = 120
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'CAMALT'
            Title.Alignment = taCenter
            Title.Caption = 'Alt?'
            Width = 26
            Visible = True
          end>
      end
    end
    object Panel2: TPanel
      Left = 591
      Top = 0
      Width = 165
      Height = 333
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alRight
      BorderWidth = 7
      ParentBackground = False
      ParentColor = True
      TabOrder = 1
      object Label11: TLabel
        Left = 8
        Top = 8
        Width = 149
        Height = 159
        Align = alClient
        Alignment = taCenter
        Caption = 
          'Para alterar o Pre'#231'o de Venda ou a Margem de Lucro Pressione [En' +
          'ter] sobre o campo.'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
        ExplicitWidth = 135
        ExplicitHeight = 56
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 256
        Width = 149
        Height = 69
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alBottom
        Caption = 'Legenda:'
        TabOrder = 0
        object Label7: TLabel
          Left = 30
          Top = 42
          Width = 88
          Height = 14
          Caption = 'Campos Alterados'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Shape1: TShape
          Left = 12
          Top = 41
          Width = 15
          Height = 15
          Brush.Color = clRed
        end
        object Label8: TLabel
          Left = 30
          Top = 22
          Width = 65
          Height = 14
          Caption = 'Selecionados'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Shape2: TShape
          Left = 12
          Top = 21
          Width = 15
          Height = 15
          Brush.Color = clAqua
        end
      end
      object GroupBox2: TGroupBox
        Left = 8
        Top = 167
        Width = 149
        Height = 89
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alBottom
        Caption = 'Informa'#231#245'es:'
        TabOrder = 1
        object Label9: TLabel
          Left = 12
          Top = 59
          Width = 74
          Height = 14
          Caption = 'Total Registros:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label10: TLabel
          Left = 19
          Top = 31
          Width = 68
          Height = 14
          Caption = 'Selecionados:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtQtdSel: TEditFocus
          Left = 89
          Top = 23
          Width = 46
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtQtdReg: TEditFocus
          Left = 89
          Top = 51
          Width = 46
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ReadOnly = True
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
    end
    object pgbProgresso: TProgressBar
      Left = 0
      Top = 333
      Width = 756
      Height = 10
      Align = alBottom
      Smooth = True
      TabOrder = 2
      Visible = False
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 129
    Width = 756
    Height = 48
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    OnEnter = dbgConsultaEnter
    OnExit = dbgConsultaExit
    OnKeyDown = dbgConsultaKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'ITE_CODITE'
        Title.Caption = 'C'#243'digo'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_CODFAB'
        Title.Caption = 'C'#243'digo Fabrica'
        Width = 82
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_DESCRI'
        Title.Caption = 'Descri'#231#227'o'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_REFERE'
        Title.Caption = 'Refer'#234'ncia'
        Width = 70
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ITE_SIGUNI'
        Title.Alignment = taCenter
        Title.Caption = 'UN'
        Width = 24
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_QTDITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_UNITAR'
        Title.Alignment = taRightJustify
        Title.Caption = 'Vlr. Unit'#225'rio'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_TOTITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Total'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_VALIPI'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total IPI'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_VALRET'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total ST'
        Width = 65
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 89
    Width = 756
    ExplicitTop = 89
    ExplicitWidth = 756
  end
  inherited pnlStatus: TPanel
    Top = 550
    Width = 756
    ExplicitTop = 550
    ExplicitWidth = 756
    inherited pnlNomeForm: TPanel
      Left = 585
      ExplicitLeft = 585
    end
    inherited pnlInfo: TPanel
      Width = 585
      ExplicitWidth = 585
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 424
    Top = 440
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 456
    Top = 440
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 668
    Top = 16
  end
  inherited qryConsulta: TUniQuery
    Left = 296
    Top = 440
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 328
    Top = 440
  end
  inherited cdsConsulta: TUniClientDataSet
    AfterScroll = cdsConsultaAfterScroll
    Left = 360
    Top = 440
  end
  inherited dtsConsulta: TDataSource
    Left = 392
    Top = 440
  end
  object dtsPrecos: TDataSource
    DataSet = cdsConsulta
    Left = 120
    Top = 344
  end
end
