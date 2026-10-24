inherited frmScriptEditor: TfrmScriptEditor
  Left = 0
  Top = 0
  Width = 1024
  Height = 700
  Caption = 'Editor de Scripts'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OldCreateOrder = False
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  OnResize = FormResize
  ExplicitWidth = 1024
  ExplicitHeight = 700
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Top = 628
    Width = 1018
    Height = 27
    TabOrder = 3
    ExplicitTop = 628
    ExplicitWidth = 1018
    ExplicitHeight = 27
    inherited FlwBotoes: TFlowPanel
      Left = 111
      Width = 828
      Height = 23
      ExplicitLeft = 111
      ExplicitWidth = 828
      ExplicitHeight = 23
    end
    inherited btnSair: TBitBtnLocked
      Left = 939
      Top = 2
      Height = 23
      Align = alRight
      Caption = 'Sair'
      ExplicitLeft = 939
      ExplicitTop = 2
      ExplicitHeight = 23
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 109
      Height = 23
      Align = alLeft
      Caption = '[ F10 ] Gravar'
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
      TabOrder = 2
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 655
    Width = 1018
    TabOrder = 5
    ExplicitTop = 655
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object pnlCode: TPanel [2]
    AlignWithMargins = True
    Left = 3
    Top = 38
    Width = 656
    Height = 420
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object gpbEditor: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 650
      Height = 414
      Align = alClient
      Caption = 'Pascal Script:'
      TabOrder = 0
      object CodeTB: TToolBar
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 640
        Height = 25
        ButtonHeight = 23
        ButtonWidth = 25
        GradientEndColor = 16770261
        GradientStartColor = 16770261
        Images = fsScriptIcons
        GradientDirection = gdHorizontal
        TabOrder = 0
        Transparent = True
        object btnRunScript: TToolButton
          Left = 0
          Top = 0
          Hint = 'Executar (F9)'
          ImageIndex = 0
          ParentShowHint = False
          ShowHint = True
          OnClick = btnRunScriptClick
        end
        object btnNextStep: TToolButton
          Left = 25
          Top = 0
          Hint = 'Pr'#243'ximo passo (F8)'
          ImageIndex = 1
          ParentShowHint = False
          ShowHint = True
          OnClick = btnRunScriptClick
        end
        object btnStopScript: TToolButton
          Left = 50
          Top = 0
          Hint = 'Parar (Ctrl+F2)'
          ImageIndex = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = btnStopScriptClick
        end
        object btnEvaluate: TToolButton
          Left = 75
          Top = 0
          Hint = 'Inspecionar (Ctrl+F7)'
          ImageIndex = 3
          ParentShowHint = False
          ShowHint = True
          OnClick = btnEvaluateClick
        end
        object btnBreakPoint: TToolButton
          Left = 100
          Top = 0
          Hint = 'Liga/desliga breakpoint (F5)'
          ImageIndex = 4
          ParentShowHint = False
          ShowHint = True
          OnClick = btnBreakPointClick
        end
      end
      object Panel3: TPanel
        Left = 2
        Top = 391
        Width = 646
        Height = 21
        Align = alBottom
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 1
        object Panel4: TPanel
          Left = 88
          Top = 0
          Width = 558
          Height = 21
          Align = alClient
          BevelInner = bvLowered
          ParentBackground = False
          ParentColor = True
          TabOrder = 0
          object pnlErrorMsg: TPanel
            Left = 2
            Top = 2
            Width = 554
            Height = 17
            Align = alClient
            BevelOuter = bvNone
            Caption = 'Error message'
            Color = clMaroon
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 0
            Visible = False
            StyleElements = [seBorder]
          end
        end
        object pnlPosition: TPanel
          Left = 0
          Top = 0
          Width = 88
          Height = 21
          Align = alLeft
          BevelInner = bvLowered
          ParentBackground = False
          ParentColor = True
          TabOrder = 1
        end
        object Panel6: TPanel
          Left = 88
          Top = 0
          Width = 0
          Height = 21
          Align = alLeft
          BevelOuter = bvNone
          Color = clTeal
          ParentBackground = False
          TabOrder = 2
          Visible = False
          object SpeedButton5: TSpeedButton
            Left = 0
            Top = 0
            Width = 23
            Height = 21
            Hint = 'Iniciar Trace'
            Align = alLeft
            Flat = True
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FF6D3327853C1395440D96450D873D12703425FF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF70372A70372ACD7727E8AD70F3
              CCA1F4CDA3E9B176D07C2C6F35296F3529FF00FFFF00FFFF00FFFF00FFFF00FF
              86411DC0620BF0C292FFFEFAFDFAF6F5E3D1F5E2D0FDF8F4FFFFFDF2C99EC669
              117B3A21FF00FFFF00FFFF00FF8C451CC16107F7DBBDFFFEFEE0A46BCE6D13C7
              5C00C96100CE6E12DE9D5FFDFAF7FAE5CCC6680D6F3528FF00FFFF00FF8C451C
              ECBD8BFFFFFFDA8F43C65600FFFFFFDC9751C75B00CA6200C75B00D58333FDFA
              F8F3CB9F6F3528FF00FFA04D10CE7721FFFDFBE8B684D06B04D06B07FFFFFFFF
              FFFFE1A870C95E00CA6300C75B00DFA061FFFFFFCF7B28703525AF5507E5AA6F
              FFFFFFDD8F3FDA8128D87B1EFFFFFFFFFFFFFFFFFFEAC198CC6708C95F00CE6E
              0DFDFAF6E9B175703525BB5F0AF0CAA1FCF4EDE19343E29242DF8A34FFFFFFFF
              FFFFFFFFFFFFFFFFF3DEC6CF7017C95F00F5E3D0F3CEA4703525C1650FF2CDA6
              FDF7F0E9A158E9A056E6994AFFFFFFFFFFFFFFFFFFFFFFFFEBC39BCD6A0DC961
              00F6E6D4F3CCA1703525C1640DEEBC88FFFFFFF1B87CF0AE69EEA75FFFFFFFFF
              FFFFFFFFFFE7B17ACE6902C96100CF7111FEFCFAE7AC6D703525BF6006E5A059
              FFFDFAFBE0C4F8BA7BF4B471FFFFFFFFFFFFE8AB6DD87B1DD27414C85C00E2AA
              71FFFFFECC7520703525FF00FFC36204FAD9B8FFFFFFFEDCB8F7B877FFFFFFEB
              AD6DE08D37DA8228D06B05DB924AFFFFFFEFC08C6B342CFF00FFFF00FFC36204
              E79E55FEEBD7FFFFFFFBDFC3F1B578E89F55E29445DE9142E8B786FFFFFFF6D8
              B7BE5F066B342CFF00FFFF00FFFF00FFC6670CE69E55FAD9B6FFFBF6FFFFFFFE
              F8F2FDF6EFFFFFFFFEF9F2ECB884BE5F09753826FF00FFFF00FFFF00FFFF00FF
              FF00FFC06005C06005E49F5AEEBA86F2CAA0F0C599E4A768CC741E783A27783A
              27FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB65C0AB86012B9
              6113B25A0FA24F0E8E451AFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 10
            ExplicitTop = 4
            ExplicitHeight = 12
          end
          object SpeedButton6: TSpeedButton
            Left = 23
            Top = 0
            Width = 23
            Height = 21
            Hint = 'Parar Trace'
            Align = alLeft
            Flat = True
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FF95440D95440D95440D95440D95440D95440DFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF70372A70372ACD7727E8AD70F3
              CCA1F4CDA3E9B176D07C2C6F35296F3529FF00FFFF00FFFF00FFFF00FFFF00FF
              86411DC0620BF0C292FFFEFAFEFAF7F5E3D1F5E2D0FDF8F4FFFFFDF2C99EC669
              117B3A21FF00FFFF00FFFF00FF8C451CC16107F7DBBDFFFFFEDE9F61CB6606C8
              5E00C85E00CA6403DC9755FDFBF7FAE5CCC6680D6F3528FF00FFFF00FF8C451C
              ECBD8BFFFFFFD88B3FD68539E1A76CD27B23D1771CE1A76DD78840D48032FDFA
              F7F3CB9F6F3528FF00FFC1650FCE7721FFFDFBE8B684CD6300FFFFFFFFFFFFDE
              9E5DDA9249FFFFFFFFFFFFC55300DFA060FFFFFFCF7B2894440CC1650FE5AA6F
              FFFFFFDD8F3FD87B1DFFFFFFFFFFFFE2A464DD9750FFFFFFFFFFFFC85C00CE6E
              0DFDFAF6E9B17594440CC1650FF0CAA1FCF4EDE19343E08D38FFFFFFFFFFFFE6
              AB70E2A05DFFFFFFFFFFFFC95F00CA6100F5E3D0F3CEA494440CC1650FF2CDA6
              FDF7F0E9A158E89C4EFFFFFFFFFFFFE9B27AE5A768FFFFFFFFFFFFC95F00CA62
              00F6E6D4F3CCA194440CC1650FEEBC88FFFFFFF1B77CEFAA62FFFFFFFFFFFFEC
              B883E8AD71FFFFFFFFFFFFC85D00CF7010FEFCFAE7AC6D94440CC1650FE5A059
              FFFDFAFBE0C4F7B674FFFFFFFFFFFFEFBD8BEBB279FFFFFFFFFFFFC65600E2AA
              71FFFFFECC752094440CFF00FFC36204FAD9B8FFFFFFFEDBB6F9C794F5C798EB
              A967E59C52E6A96BD98837DA9148FFFFFFEFC08C6B342CFF00FFFF00FFC36204
              E79E55FEEBD7FFFFFFFBDDBFF1B475E8A056E29242DC8A37E7B37EFFFFFFF6D8
              B7BE5F066B342CFF00FFFF00FFFF00FFC6670CE69E55FAD9B6FFFBF6FFFFFFFE
              F8F2FDF6EFFFFFFFFEF9F2ECB884BE5F09753826FF00FFFF00FFFF00FFFF00FF
              FF00FFC06005C06005E49F5AEEBA86F2CAA0F0C599E4A768CC741E783A27783A
              27FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB96113B96113B9
              6113B96113B96113B96113FF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 93
            ExplicitTop = 13
            ExplicitHeight = 22
          end
          object SpeedButton7: TSpeedButton
            Left = 46
            Top = 0
            Width = 23
            Height = 21
            Hint = 'Salvar Trace'
            Align = alLeft
            Flat = True
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FF97433F97433FB59A9BB59A9BB59A9BB5
              9A9BB59A9BB59A9BB59A9B93303097433FFF00FFFF00FFFF00FFFF00FF97433F
              D66868C66060E5DEDF92292A92292AE4E7E7E0E3E6D9DFE0CCC9CC8F201FAF46
              4697433FFF00FFFF00FFFF00FF97433FD06566C25F5FE9E2E292292A92292AE2
              E1E3E2E6E8DDE2E4CFCCCF8F2222AD464697433FFF00FFFF00FFFF00FF97433F
              D06565C15D5DECE4E492292A92292ADFDDDFE1E6E8E0E5E7D3D0D28A1E1EAB44
              4497433FFF00FFFF00FFFF00FF97433FD06565C15B5CEFE6E6EDE5E5E5DEDFE0
              DDDFDFE0E2E0E1E3D6D0D2962A2AB24A4A97433FFF00FFFF00FFFF00FF97433F
              CD6263C86060C96767CC7272CA7271C66969C46464CC6D6CCA6667C55D5DCD65
              6597433FFF00FFFF00FFFF00FF97433FB65553C27B78D39D9CD7A7A5D8A7A6D8
              A6A5D7A09FD5A09FD7A9A7D8ABABCC666797433FFF00FFFF00FFFF00FF97433F
              CC6667F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC66
              6797433FFF00FFFF00FFFF00FF97433FCC6667F9F9F9F9F9F9F9F9F9F9F9F9F9
              F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC666797433FFF00FFFF00FFFF00FF97433F
              CC6667F9F9F9CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDF9F9F9CC66
              6797433FFF00FFFF00FFFF00FF97433FCC6667F9F9F9F9F9F9F9F9F9F9F9F9F9
              F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC666797433FFF00FFFF00FFFF00FF97433F
              CC6667F9F9F9CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDF9F9F9CC66
              6797433FFF00FFFF00FFFF00FF97433FCC6667F9F9F9F9F9F9F9F9F9F9F9F9F9
              F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC666797433FFF00FFFF00FFFF00FFFF00FF
              97433FF9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F99743
              3FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 122
            ExplicitTop = 13
            ExplicitHeight = 22
          end
          object SpeedButton8: TSpeedButton
            Left = 69
            Top = 0
            Width = 23
            Height = 21
            Hint = 'Monitorar Trace'
            Align = alLeft
            Flat = True
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              00000000000000000000000000000000000000000000000000000000000C0000
              0012000000140000001400000014000000140000001500000015000000150000
              0015000000160000001600000016000000150000000E00000003255080C3336F
              B3FF336EB3FF336EB3FF326EB2FF326DB2FF326CB2FF316CB2FF316CB1FF306B
              B1FF306BB1FF2F6BB1FF2E6AB0FF2F69B0FF214B7FC60000000D3873B5FF94DD
              FAFF77D2F9FF75D2F8FF73D1F9FF72D0F8FF70CFF8FF6ECEF8FF6DCEF8FF6BCC
              F8FF6ACCF8FF68CCF8FF66CBF8FF65CAF7FF316CB1FF000000143C77B8FF9BE0
              FBFF3C2A23FF3D2A23FF3D2A23FF3C2A22FF3D2A23FF3D2A23FF3C2A23FF3C2A
              23FF3C2A23FF3D2A23FF3D2A23FF68CBF7FF346FB3FF000000153F7BBAFF9FE1
              FBFF402D25FF5D4439FFFFFFFFFFFFFFFFFFFFFFFFFF5E443AFF5E443AFF5E44
              3AFF5E443AFF5E443AFF402D25FF68CBF7FF3773B5FF00000014447EBBFFA4E4
              FBFF453029FF674C41FF674B41FF674B40FF674B41FF674B41FF664C40FF674B
              40FF664B41FF674C41FF443129FF6CCDF8FF3B76B8FF000000134782BEFFABE6
              FBFF49342CFF705348FF715448FF705448FF715448FF705448FF715449FF7053
              49FF705448FF705449FF4A342CFF6FCFF8FF3F79BAFF000000124C86C0FFB1E9
              FCFF4E3830FF7B5B4FFF7C5E52FF7E6155FF816256FF816458FF806156FF8061
              54FF7D5D52FF7A5C50FF4E3831FF72D0F8FF427DBCFF00000011508AC3FFB7EB
              FCFF533C34FF8A6B60FF8D6E63FF8D6E62FF8D6F63FF8D6E63FF8E6F62FF8D6E
              63FF8D6E62FF8B6C5FFF533C34FF77D3F8FF4681BEFF00000010538EC4FFBBEC
              FCFF574037FF97796BFF97796CFF97786CFF97786CFF97796BFF97796BFF9778
              6CFF97796BFF97796CFF584037FF7AD5F9FF4B85C0FF0000000F5792C7FFBFEF
              FCFF5C433BFF9F8074FF9F8074FF9F8073FF9F8073FF9F8073FF9F8074FF9F80
              73FF9F8074FF9F8074FF5C443AFF7ED6FAFF4E8AC2FF0000000E5A96C8FFC3F0
              FDFF5F463DFF5F463DFF60463DFF60463DFF5F463DFF60463DFF5F463DFF5F46
              3DFF60463DFF5F463DFF5F463EFF83D8FAFF538DC5FF0000000E5E99CBFFE1F8
              FEFFE0F7FEFFDEF7FEFFDCF7FEFFDAF6FDFFD8F5FEFFD6F4FDFFD4F4FDFFD1F3
              FDFFCEF2FDFFCCF1FDFFC9F0FDFFC6F0FCFF5791C6FF0000000C487497C2619C
              CDFF619BCCFF609BCBFF5F9ACCFF5F9ACBFF5F99CBFF5E99CAFF5D99CAFF5D98
              CAFF5D97C9FF5C96CAFF5B97C9FF5B96C9FF436F95C400000008000000050000
              0007000000080000000800000008000000080000000900000009000000090000
              00090000000A0000000A0000000A0000000A0000000700000002}
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 86
            ExplicitTop = 4
            ExplicitHeight = 16
          end
        end
      end
    end
  end
  object pnlTreeView: TPanel [3]
    AlignWithMargins = True
    Left = 665
    Top = 38
    Width = 350
    Height = 420
    Align = alRight
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object cxpStructure: TcxPageControl
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 344
      Height = 414
      Align = alClient
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      Properties.ActivePage = tbsVariables
      Properties.CustomButtons.Buttons = <>
      Properties.Style = 10
      ClientRectBottom = 414
      ClientRectRight = 344
      ClientRectTop = 19
      object tbsVariables: TcxTabSheet
        Caption = 'Vari'#225'veis'
        ImageIndex = 1
        object trvVariables: TTreeView
          AlignWithMargins = True
          Left = 3
          Top = 31
          Width = 338
          Height = 361
          Align = alClient
          Images = fsTreeIcons
          Indent = 19
          ReadOnly = True
          TabOrder = 0
          OnDblClick = trvVariablesDblClick
        end
        object Panel2: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 338
          Height = 25
          Margins.Bottom = 0
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          StyleElements = []
          object pnlPesquisar: TPanel
            AlignWithMargins = True
            Left = 160
            Top = 5
            Width = 178
            Height = 20
            Margins.Top = 5
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alRight
            BevelOuter = bvNone
            Ctl3D = True
            ParentBackground = False
            ParentCtl3D = False
            TabOrder = 0
            StyleElements = [seFont, seBorder]
            object Shape1: TShape
              Left = 0
              Top = 0
              Width = 178
              Height = 20
              Align = alClient
              ExplicitLeft = 32
              ExplicitTop = 8
              ExplicitWidth = 65
              ExplicitHeight = 65
            end
            object Image1: TImage
              AlignWithMargins = True
              Left = 2
              Top = 3
              Width = 19
              Height = 15
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Picture.Data = {
                0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
                0000001008060000001FF3FF61000000097048597300000EC200000EC2011528
                4A8000000012744558745469746C650046696E643B5365617263683BAD078F62
                0000016A49444154785EA591CD4A02611486BD8A46A789F1278568DFD65DB408
                341A1DB5C69F748CB983C84D942EEC565A0981E6FC383FB60964EA0A0A6951B6
                19086C33703A332048F6CDC617DE8FB3799F73CE774200B096FD67A16DD14CC7
                1B660FFD1EAB1B9E7BD19A990EAD6A159014CD56B26941EA7C0C471D1BB23736
                24C43144AB06B015BD1504F03B27450B326D1BA65F3FB090571F5E4D802D8F80
                A98C0E8800EC64ED4A8F7EE0AF5E3FE6906A18C008EA3D11106F584EF1F60548
                CA759E8139D1666440DD740A5D32806BDB0850C880E89961ED4816BC7DCEFF5D
                2151D7812E05ACE09D8AAD99AEF761D3D9D22762BD7FF9049B25052225B51D78
                46B632BAC07341ACAA43F67A0219342B6818D6BC30448AAA4BF3324F02F862CA
                CADE96A0F79953CDA105348E4D17D52E861180531414974208014056981F4A18
                86302F4398935D8A937912800CE18612951F009597813AEE7F1300C1DAC83D34
                A97CDFD9E00677CB8075BC3EE0171A811CE8F7E0E9CD0000000049454E44AE42
                6082}
            end
            object edtPesquisar: TEdit
              AlignWithMargins = True
              Left = 23
              Top = 3
              Width = 150
              Height = 15
              Margins.Bottom = 0
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              Color = clWhite
              Ctl3D = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              StyleElements = []
              OnChange = edtPesquisarChange
            end
          end
          object cxButton1: TcxButton
            Left = 0
            Top = 5
            Width = 25
            Height = 25
            Hint = 'Expandir todos'
            Caption = 'cxButton1'
            OptionsImage.Glyph.SourceDPI = 96
            OptionsImage.Glyph.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              6100000023744558745469746C6500457870616E644669656C645069766F7454
              61626C653B457870616E643B9D5605350000010D49444154785EA593B16A0241
              10868F85D333C809A6B3381B21A4B2389B600A215D8A04828D82700A012DCE26
              85950A2248429ABC401EC05A11CE52D25ADAA4C813E419C619DD6515B34EE006
              3EFE9DD965EE879FB30E4A846FE559F7FD1648A927AACD5730B17FA32BD199DC
              C0F7EF1448A9476CC4452EFFC095F796680EFC596B580262F53306750EFAFE1C
              EF53C805921E7D4470885A90A8F78ABB2F2F362F47E05C39B1B49B5307CE43FB
              2A7A0AAF8198AE0350679AD3BD5A6074806411EFFEB9009F5F8F404ABD9CB30E
              847C94A9D4BCE55D230FA4D4230E9382AD33D04E7252FF9D82423971A40A4992
              4B81E56C0A0060449529056E417C07CCBFC03BE053E017E8144EA1B9A087B1D8
              02C6B8419680F89FEB0000000049454E44AE426082}
            PaintStyle = bpsGlyph
            ParentShowHint = False
            ShowHint = True
            SpeedButtonOptions.CanBeFocused = False
            SpeedButtonOptions.Flat = True
            TabOrder = 1
            OnClick = btnExpandTreeClick
          end
          object cxButton2: TcxButton
            Left = 25
            Top = 5
            Width = 25
            Height = 25
            Hint = 'Recolher todos'
            Caption = 'cxButton1'
            OptionsImage.Glyph.SourceDPI = 96
            OptionsImage.Glyph.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              6100000024744558745469746C6500436F6C6C617073654669656C645069766F
              745461626C653B5069766F743B83E6DD1E000000B849444154785EBDD33D0A02
              311005E010D81F4552ACA59E43C51B686BD6DE7B58D9595A791145D8C6561616
              AFE20DC617C8C0B2318CA218F88A64E031611245445158DA6EF614E3EA524002
              06862F185F57BA29EDE9BE2EA9ABB6AB33EA3DE8C36077A8A88D03D2DB72418F
              E336E0CE5D1D5ADD841DE497E9A4BACE67D4E5CE5D9D03A21D4001231833BF2F
              DEE94043CA77657E9F0B534894B0C42988EF00B2D814A400A91BF371C0BF3B90
              FF8214F0E3298432FE8D5F7902F1077F82204B1ABD0000000049454E44AE4260
              82}
            PaintStyle = bpsGlyph
            ParentShowHint = False
            ShowHint = True
            SpeedButtonOptions.CanBeFocused = False
            SpeedButtonOptions.Flat = True
            TabOrder = 2
            OnClick = btnCollapseTreeClick
          end
        end
      end
      object tbsClasses: TcxTabSheet
        Caption = 'Classes'
        ImageIndex = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object trvClasses: TTreeView
          AlignWithMargins = True
          Left = 3
          Top = 31
          Width = 338
          Height = 361
          Align = alClient
          Images = fsTreeIcons
          Indent = 19
          ReadOnly = True
          TabOrder = 0
          OnDblClick = trvClassesDblClick
        end
        object Panel1: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 338
          Height = 25
          Margins.Bottom = 0
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          StyleElements = []
          object Panel5: TPanel
            AlignWithMargins = True
            Left = 160
            Top = 5
            Width = 178
            Height = 20
            Margins.Top = 5
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alRight
            BevelOuter = bvNone
            Ctl3D = True
            ParentBackground = False
            ParentCtl3D = False
            TabOrder = 0
            StyleElements = [seFont, seBorder]
            object Shape2: TShape
              Left = 0
              Top = 0
              Width = 178
              Height = 20
              Align = alClient
              ExplicitLeft = 32
              ExplicitTop = 8
              ExplicitWidth = 65
              ExplicitHeight = 65
            end
            object Image2: TImage
              AlignWithMargins = True
              Left = 2
              Top = 3
              Width = 19
              Height = 15
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Picture.Data = {
                0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
                0000001008060000001FF3FF61000000097048597300000EC200000EC2011528
                4A8000000012744558745469746C650046696E643B5365617263683BAD078F62
                0000016A49444154785EA591CD4A02611486BD8A46A789F1278568DFD65DB408
                341A1DB5C69F748CB983C84D942EEC565A0981E6FC383FB60964EA0A0A6951B6
                19086C33703A332048F6CDC617DE8FB3799F73CE774200B096FD67A16DD14CC7
                1B660FFD1EAB1B9E7BD19A990EAD6A159014CD56B26941EA7C0C471D1BB23736
                24C43144AB06B015BD1504F03B27450B326D1BA65F3FB090571F5E4D802D8F80
                A98C0E8800EC64ED4A8F7EE0AF5E3FE6906A18C008EA3D11106F584EF1F60548
                CA759E8139D1666440DD740A5D32806BDB0850C880E89961ED4816BC7DCEFF5D
                2151D7812E05ACE09D8AAD99AEF761D3D9D22762BD7FF9049B25052225B51D78
                46B632BAC07341ACAA43F67A0219342B6818D6BC30448AAA4BF3324F02F862CA
                CADE96A0F79953CDA105348E4D17D52E861180531414974208014056981F4A18
                86302F4398935D8A937912800CE18612951F009597813AEE7F1300C1DAC83D34
                A97CDFD9E00677CB8075BC3EE0171A811CE8F7E0E9CD0000000049454E44AE42
                6082}
            end
            object Edit1: TEdit
              AlignWithMargins = True
              Left = 23
              Top = 3
              Width = 150
              Height = 15
              Margins.Bottom = 0
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              Color = clWhite
              Ctl3D = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              StyleElements = []
              OnChange = edtPesquisarChange
            end
          end
          object cxButton3: TcxButton
            Left = 0
            Top = 5
            Width = 25
            Height = 25
            Hint = 'Expandir todos'
            Caption = 'cxButton1'
            OptionsImage.Glyph.SourceDPI = 96
            OptionsImage.Glyph.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              6100000023744558745469746C6500457870616E644669656C645069766F7454
              61626C653B457870616E643B9D5605350000010D49444154785EA593B16A0241
              10868F85D333C809A6B3381B21A4B2389B600A215D8A04828D82700A012DCE26
              85950A2248429ABC401EC05A11CE52D25ADAA4C813E419C619DD6515B34EE006
              3EFE9DD965EE879FB30E4A846FE559F7FD1648A927AACD5730B17FA32BD199DC
              C0F7EF1448A9476CC4452EFFC095F796680EFC596B580262F53306750EFAFE1C
              EF53C805921E7D4470885A90A8F78ABB2F2F362F47E05C39B1B49B5307CE43FB
              2A7A0AAF8198AE0350679AD3BD5A6074806411EFFEB9009F5F8F404ABD9CB30E
              847C94A9D4BCE55D230FA4D4230E9382AD33D04E7252FF9D82423971A40A4992
              4B81E56C0A0060449529056E417C07CCBFC03BE053E017E8144EA1B9A087B1D8
              02C6B8419680F89FEB0000000049454E44AE426082}
            PaintStyle = bpsGlyph
            ParentShowHint = False
            ShowHint = True
            SpeedButtonOptions.CanBeFocused = False
            SpeedButtonOptions.Flat = True
            TabOrder = 1
            OnClick = btnExpandTreeClick
          end
          object cxButton4: TcxButton
            Left = 25
            Top = 5
            Width = 25
            Height = 25
            Hint = 'Recolher todos'
            Caption = 'cxButton1'
            OptionsImage.Glyph.SourceDPI = 96
            OptionsImage.Glyph.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              6100000024744558745469746C6500436F6C6C617073654669656C645069766F
              745461626C653B5069766F743B83E6DD1E000000B849444154785EBDD33D0A02
              311005E010D81F4552ACA59E43C51B686BD6DE7B58D9595A791145D8C6561616
              AFE20DC617C8C0B2318CA218F88A64E031611245445158DA6EF614E3EA524002
              06862F185F57BA29EDE9BE2EA9ABB6AB33EA3DE8C36077A8A88D03D2DB72418F
              E336E0CE5D1D5ADD841DE497E9A4BACE67D4E5CE5D9D03A21D4001231833BF2F
              DEE94043CA77657E9F0B534894B0C42988EF00B2D814A400A91BF371C0BF3B90
              FF8214F0E3298432FE8D5F7902F1077F82204B1ABD0000000049454E44AE4260
              82}
            PaintStyle = bpsGlyph
            ParentShowHint = False
            ShowHint = True
            SpeedButtonOptions.CanBeFocused = False
            SpeedButtonOptions.Flat = True
            TabOrder = 2
            OnClick = btnCollapseTreeClick
          end
        end
      end
      object tbsFunctions: TcxTabSheet
        Caption = 'Fun'#231#245'es'
        ImageIndex = 2
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object trvFunctions: TTreeView
          AlignWithMargins = True
          Left = 3
          Top = 31
          Width = 338
          Height = 361
          Align = alClient
          Images = fsTreeIcons
          Indent = 19
          ReadOnly = True
          TabOrder = 0
          OnDblClick = trvFunctionsDblClick
        end
        object Panel7: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 338
          Height = 25
          Margins.Bottom = 0
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          StyleElements = []
          object Panel8: TPanel
            AlignWithMargins = True
            Left = 160
            Top = 5
            Width = 178
            Height = 20
            Margins.Top = 5
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alRight
            BevelOuter = bvNone
            Ctl3D = True
            ParentBackground = False
            ParentCtl3D = False
            TabOrder = 0
            StyleElements = [seFont, seBorder]
            object Shape3: TShape
              Left = 0
              Top = 0
              Width = 178
              Height = 20
              Align = alClient
              ExplicitLeft = 32
              ExplicitTop = 8
              ExplicitWidth = 65
              ExplicitHeight = 65
            end
            object Image3: TImage
              AlignWithMargins = True
              Left = 2
              Top = 3
              Width = 19
              Height = 15
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Picture.Data = {
                0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
                0000001008060000001FF3FF61000000097048597300000EC200000EC2011528
                4A8000000012744558745469746C650046696E643B5365617263683BAD078F62
                0000016A49444154785EA591CD4A02611486BD8A46A789F1278568DFD65DB408
                341A1DB5C69F748CB983C84D942EEC565A0981E6FC383FB60964EA0A0A6951B6
                19086C33703A332048F6CDC617DE8FB3799F73CE774200B096FD67A16DD14CC7
                1B660FFD1EAB1B9E7BD19A990EAD6A159014CD56B26941EA7C0C471D1BB23736
                24C43144AB06B015BD1504F03B27450B326D1BA65F3FB090571F5E4D802D8F80
                A98C0E8800EC64ED4A8F7EE0AF5E3FE6906A18C008EA3D11106F584EF1F60548
                CA759E8139D1666440DD740A5D32806BDB0850C880E89961ED4816BC7DCEFF5D
                2151D7812E05ACE09D8AAD99AEF761D3D9D22762BD7FF9049B25052225B51D78
                46B632BAC07341ACAA43F67A0219342B6818D6BC30448AAA4BF3324F02F862CA
                CADE96A0F79953CDA105348E4D17D52E861180531414974208014056981F4A18
                86302F4398935D8A937912800CE18612951F009597813AEE7F1300C1DAC83D34
                A97CDFD9E00677CB8075BC3EE0171A811CE8F7E0E9CD0000000049454E44AE42
                6082}
            end
            object Edit2: TEdit
              AlignWithMargins = True
              Left = 23
              Top = 3
              Width = 150
              Height = 15
              Margins.Bottom = 0
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              Color = clWhite
              Ctl3D = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              StyleElements = []
              OnChange = edtPesquisarChange
            end
          end
          object cxButton5: TcxButton
            Left = 0
            Top = 5
            Width = 25
            Height = 25
            Hint = 'Expandir todos'
            Caption = 'cxButton1'
            OptionsImage.Glyph.SourceDPI = 96
            OptionsImage.Glyph.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              6100000023744558745469746C6500457870616E644669656C645069766F7454
              61626C653B457870616E643B9D5605350000010D49444154785EA593B16A0241
              10868F85D333C809A6B3381B21A4B2389B600A215D8A04828D82700A012DCE26
              85950A2248429ABC401EC05A11CE52D25ADAA4C813E419C619DD6515B34EE006
              3EFE9DD965EE879FB30E4A846FE559F7FD1648A927AACD5730B17FA32BD199DC
              C0F7EF1448A9476CC4452EFFC095F796680EFC596B580262F53306750EFAFE1C
              EF53C805921E7D4470885A90A8F78ABB2F2F362F47E05C39B1B49B5307CE43FB
              2A7A0AAF8198AE0350679AD3BD5A6074806411EFFEB9009F5F8F404ABD9CB30E
              847C94A9D4BCE55D230FA4D4230E9382AD33D04E7252FF9D82423971A40A4992
              4B81E56C0A0060449529056E417C07CCBFC03BE053E017E8144EA1B9A087B1D8
              02C6B8419680F89FEB0000000049454E44AE426082}
            PaintStyle = bpsGlyph
            ParentShowHint = False
            ShowHint = True
            SpeedButtonOptions.CanBeFocused = False
            SpeedButtonOptions.Flat = True
            TabOrder = 1
            OnClick = btnExpandTreeClick
          end
          object cxButton6: TcxButton
            Left = 25
            Top = 5
            Width = 25
            Height = 25
            Hint = 'Recolher todos'
            Caption = 'cxButton1'
            OptionsImage.Glyph.SourceDPI = 96
            OptionsImage.Glyph.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              6100000024744558745469746C6500436F6C6C617073654669656C645069766F
              745461626C653B5069766F743B83E6DD1E000000B849444154785EBDD33D0A02
              311005E010D81F4552ACA59E43C51B686BD6DE7B58D9595A791145D8C6561616
              AFE20DC617C8C0B2318CA218F88A64E031611245445158DA6EF614E3EA524002
              06862F185F57BA29EDE9BE2EA9ABB6AB33EA3DE8C36077A8A88D03D2DB72418F
              E336E0CE5D1D5ADD841DE497E9A4BACE67D4E5CE5D9D03A21D4001231833BF2F
              DEE94043CA77657E9F0B534894B0C42988EF00B2D814A400A91BF371C0BF3B90
              FF8214F0E3298432FE8D5F7902F1077F82204B1ABD0000000049454E44AE4260
              82}
            PaintStyle = bpsGlyph
            ParentShowHint = False
            ShowHint = True
            SpeedButtonOptions.CanBeFocused = False
            SpeedButtonOptions.Flat = True
            TabOrder = 2
            OnClick = btnCollapseTreeClick
          end
        end
      end
    end
  end
  object pnlBottom: TPanel [4]
    AlignWithMargins = True
    Left = 3
    Top = 464
    Width = 1012
    Height = 161
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object gpbWatchList: TGroupBox
      AlignWithMargins = True
      Left = 662
      Top = 3
      Width = 347
      Height = 155
      Align = alRight
      Caption = 'Lista de observa'#231#227'o:'
      TabOrder = 0
    end
    object gpbLogs: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 653
      Height = 155
      Align = alClient
      Caption = 'Log de execu'#231#227'o:'
      TabOrder = 1
      object memLog: TRichEdit
        AlignWithMargins = True
        Left = 5
        Top = 49
        Width = 643
        Height = 101
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
        WordWrap = False
        StyleElements = [seClient, seBorder]
        Zoom = 100
      end
      object ToolBar1: TToolBar
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 643
        Height = 25
        ButtonHeight = 23
        ButtonWidth = 25
        Images = fsScriptIcons
        TabOrder = 1
        object btnClearLog: TToolButton
          Left = 0
          Top = 0
          Hint = 'Limpar log'
          ImageIndex = 5
          ParentShowHint = False
          ShowHint = True
          OnClick = btnClearLogClick
        end
      end
    end
  end
  object pnlFundo: TPanel [5]
    Left = 0
    Top = 0
    Width = 1018
    Height = 35
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblPrompt: TLabel
      AlignWithMargins = True
      Left = 7
      Top = 9
      Width = 95
      Height = 19
      Margins.Left = 6
      Margins.Top = 8
      Margins.Bottom = 6
      Align = alLeft
      Caption = 'Descri'#231#227'o do Script:'
      Layout = tlCenter
      ExplicitHeight = 13
    end
    object edtDescription: TEditFocus
      AlignWithMargins = True
      Left = 105
      Top = 7
      Width = 902
      Height = 21
      Margins.Left = 0
      Margins.Top = 6
      Margins.Right = 10
      Margins.Bottom = 6
      Align = alLeft
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Ctl3D = True
      MaxLength = 255
      ParentCtl3D = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object fsScriptIcons: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 14156000
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000010000000200000001000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000040000000A00000009000000040000000100000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000003070615205743B9081510410000000F0000000700000003000000010000
          0000000000000000000000000000000000000000000000000000000000000000
          000003080616328466FF2F7E64FC1D4C3CA6050D0A300000000E000000060000
          0002000000010000000000000000000000000000000000000000000000000000
          00000308061635896AFF56C8A2FF46A57DFF318064F51942348F020605220000
          000C000000050000000200000000000000000000000000000000000000000000
          000003080616388E6FFF63CEACFF49C69EFF51C29BFF4BA680FF317E63EA1536
          2A77010202190000000B00000005000000010000000000000000000000000000
          0000030907163A9373FF70D4B4FF4EC9A2FF4EC9A2FF4EC9A2FF55BF97FF4DA7
          82FF2F7960DC1029215F00000010000000050000000100000000000000000000
          0000040907163D9978FF7CD8BCFF53CCA7FF53CCA7FF53CCA7FF53CCA7FF5CCF
          ACFF64C09DFF52A886FF2D715AC40916112B0000000100000000000000000000
          000004090716409E7EFF89DDC4FF58CFABFF59CFACFF6ED5B6FF85DCC1FF8ADD
          C4FF8ADDC4FF7AC7A9FF5BAD90FF16362C5B0000000000000000000000000000
          0000040A081642A483FF94E1CAFF66D4B4FF87DEC4FF8EE0C8FF8EE0C8FF86D2
          B7FF66B89AFF337E66C810292141000000000000000000000000000000000000
          0000040A081645A987FFA6E7D4FF8FE1C9FF91E2CBFF94DCC4FF74C2A5FF3B91
          75DD183B2F5A0001010200000000000000000000000000000000000000000000
          0000040A081648AE8CFFC0EFE2FFA2E6D1FF7CC9ADFF42A082ED204E40750204
          0307000000000000000000000000000000000000000000000000000000000000
          0000040A09144DB392FF8AD0B7FF48AC8CF72862508D050B0911000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000040B09114CB594FE317761A70915121F0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000020504070F231D3200000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000200000007190E0839542D1A9E7B4126DD914D2DFF914C2DFF7E43
          27E35B301CAB20110A4900000009000000020000000000000000000000000000
          000204020110572F1C9D9A5936FFBA8153FFCD9C67FFDDAF75FFDEB076FFCD9C
          67FFBB8354FF995734FF643720B5070402190000000300000000000000010402
          010E703F26C0AF734BFFDBAE76FFDFB27AFFE7C495FFE4BF8BFFDFB47BFFDFB3
          78FFDEB37AFFD7A973FFAB7048FF7B452BD50704021800000002000000055834
          2095B37951FFE0B57DFFE0B57CFFE0B57CFFAA7044FFAC7950FFE2BD8EFFE2B9
          82FFE0B57CFFE0B57DFFE1B67EFFB47A51FF653B24AF00000009170E092DA469
          46FADEB580FFE2B880FFE1B980FFE3B984FFAA7043FFD8C3B7FF9E6944FFD4AD
          83FFE6C291FFE1B880FFE1B780FFDFB781FFA86B47FF24150E475938248FC796
          6CFFE4BD88FFE9C99AFFECCEA5FFECCEA5FFA97043FFF8F4F0FFEFE7E3FFA879
          5DFFBB8E67FFE9CA9EFFE6C08DFFE3BD87FFC8976CFF6B422BAF87573BCADCB4
          86FFE6C391FFBB8B5FFFA86F43FFA96F42FFA86E42FFF7F0EBFFF9F3EEFFFCFA
          F8FFC6A895FFA26E48FFE0C098FFE8C99BFFDBB485FF975F40E5A36C4AE9E7C6
          9CFFE8C999FFA76E41FFFFFFFFFFFFFFFFFFFFFFFFFFF8F4F0FFF9F4F0FFF8F3
          F0FFFBF8F6FFE0D1C9FF9C6646FFC89F75FFE9CA9DFFAC714DFAA3704DE3EBD1
          ACFFEBCDA0FFA76D41FFDFD1CBFFE0D3CEFFE1D5CFFFF9F6F3FFFAF7F4FFF9F6
          F2FFECE4E0FFCDB7AAFF9B6746FFC9A075FFEFD5B0FFB47B55FC8F6649C3E7CC
          AEFFEDD1A7FFB8865AFFA66D40FFA66C41FFA66D40FFFAF8F6FFF8F5F2FFE7DE
          DAFFB4917CFFA26D47FFE0BF95FFEDD2A7FFE9D0B0FFA17150DF5C43317DDBBA
          9BFFF0D9B5FFEED4AAFFEED5ABFFEFD4AAFFA66C40FFF2EEEAFFD8C9C1FF9D6E
          50FFBC926AFFEED2A8FFEFD5ABFFF0D8B3FFDEBEA0FF72523B9E15100C1FC294
          73F5F4E3CCFFF0D8B1FFF0D7AFFFEFD7B0FFA56B3FFFC3A797FF9A6541FFD9B8
          91FFF0D7AFFFF0D7B0FFF0D8B1FFF4E4CCFFC89774FC231A1336000000026049
          377CD8B393FFF6EAD3FFF2DCB8FFF1DAB4FFA56B3FFFAD7E59FFEDD3ADFFF2DA
          B4FFF1DAB4FFF3DDBAFFF7EBD5FFD8B495FF7458429A00000005000000000202
          010583654DA5DAB696FFF6E9D7FFF6EAD0FFF5E4C8FFF3E0BFFFF3E0BEFFF5E5
          C7FFF6E9CFFFF4E5D2FFD8B392FF906F54B80504030C00000001000000000000
          000000000002604B3B78CCA481F7E4C6ACFFEDD7C1FFF5E7D5FFF6E8D6FFEDD8
          C2FFE4C7ACFFCEA380F97158448F020201080000000100000000000000000000
          0000000000000000000114100C1B66513F7E9F7E61C2B38E6EDAB89171DFA581
          64C86A5442851E18122900000003000000010000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0001000000030000000500000006000000060000000600000006000000060000
          0006000000060000000600000005000000030000000100000000000000000000
          00030000000D000000180000001B0000001B0000001B0000001B0000001B0000
          001B0000001B0000001B000000180000000D0000000300000000000000000000
          0005215944BB2E7D60FC2F7E61FF2F7E61FF2F7E61FF2F7E61FF2F7E61FF2F7E
          61FF2F7E61FF2F7E61FF2E7D60FC215944BB0000000500000000000000000000
          0006307E64FA52C295FF50C69FFF50C69FFF50C69FFF50C69FFF50C69FFF50C6
          9FFF50C69FFF50C69FFF53C295FF307F64FB0000000600000000000000000000
          000634886AFF5CCBA7FF48C59CFF48C59CFF48C59CFF48C59CFF48C59CFF48C5
          9CFF48C59CFF48C59CFF5CCBA7FF34886AFF0000000600000000000000000000
          0006378D70FF69D1AFFF4CC8A0FF4CC8A0FF4CC8A0FF4CC8A0FF4CC8A0FF4CC8
          A0FF4CC8A0FF4CC8A0FF69D1AFFF378D70FF0000000600000000000000000000
          00063A9375FF77D6B8FF51CBA5FF5ECFACFF6CD3B3FF72D5B6FF72D5B6FF6CD3
          B3FF5ECFACFF51CBA5FF77D6B8FF3A9375FF0000000600000000000000000000
          00063D9A7BFF85DBC1FF6FD4B6FF78D7BAFF78D7BAFF78D7BAFF78D7BAFF78D7
          BAFF78D7BAFF6FD4B6FF85DBC1FF3D9A7BFF0000000600000000000000000000
          000640A081FFA1E4D0FF7BD9BDFF7BD9BDFF7BD9BDFF7BD9BDFF7BD9BDFF7BD9
          BDFF7BD9BDFF7BD9BDFFA1E4D0FF40A081FF0000000600000000000000000000
          000643A686FFB0E9D9FF7FDCC1FF7FDCC1FF7FDCC1FF7FDCC1FF7FDCC1FF7FDC
          C1FF7FDCC1FF7FDCC1FFB0E9D9FF43A686FF0000000600000000000000000000
          000646AB8CFFB9ECDEFF82DEC5FF82DEC5FF82DEC5FF82DEC5FF82DEC5FF82DE
          C5FF82DEC5FF82DEC5FFB9ECDEFF46AB8CFF0000000600000000000000000000
          000549B190FFC1F0E3FF85E1C8FF85E1C8FF85E1C8FF85E1C8FF85E1C8FF85E1
          C8FF85E1C8FF85E1C8FFC1F0E3FF49B190FF0000000500000000000000000000
          000349B191F9C3EEDEFFC8F2E6FFC8F2E6FFC8F2E6FFC8F2E6FFC8F2E6FFC8F2
          E6FFC8F2E6FFC8F2E6FFC3EEDEFF4AB192FA0000000300000000000000000000
          000137836BB54BB595FA4DB998FF4DB998FF4DB998FF4DB998FF4DB998FF4DB9
          98FF4DB998FF4DB998FF4BB595FA37836BB50000000100000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0002000000070000000B0000000C0000000C0000000C0000000C0000000D0000
          000D0000000F0000001C0713339C0F276AFF0A193A980000000B000000000000
          00067B4B2ABEAB683AFFAB6839FFAA6638FFAA6737FFAA6636FFA96536FFB77C
          54FFBA8E6FFF585468FF417CB9FF70C7FFFF265198FF00000010000000000000
          0009AE6D3FFFDBAD76FFD7A56CFFD9AE7BFFD9B488FFD9B890FFD6B690FFD1B2
          8EFF676B7DFF4C83BCFF83CFFFFF5694CEFF142B4D980000000A000000000000
          0009B07144FFDEB47FFFDCB384FFD0AF8AFF9F7253FF8D5A3CFF8B593BFF7858
          4AFF577EA6FF92D4FAFF619CD0FF6C7284FF0000001900000002000000000000
          0008B4764AFFE3C196FFCFAE8AFF926042FFC8A583FFF0D9B9FFF0DCBEFFC7A8
          8BFF895D43FF6891B2FF7D8C9CFFBF9577FF0000000D00000000000000000000
          0007B67C50FFE7CBA8FFA77B5CFFC8A482FFF8DBADFFF7D6A6FFF8DBACFFFAE3
          BFFFC8A88CFF826354FFD9C1A1FFBD8863FF0000000A00000000000000000000
          0007BA8155FFEAD5B7FF976647FFF2DBB9FFFCECCEFFFCEFD5FFF9E0B8FFF8DE
          B4FFF3E1C7FF8E5C3FFFE2C9A8FFB4774AFF0000000900000000000000000000
          0006BC875CFFEEDABEFF9C6B4DFFF4DEBDFFFEF8E8FFFEF7E5FFFDF0D9FFF8DE
          B6FFF3E2C8FF926042FFE5CDAEFFB67C50FF0000000900000000000000000000
          0005C08C62FFF0DEC2FFB48C6DFFCEAE90FFFCECD1FFFEFAEBFFFDF0D7FFFAE5
          C4FFCBAC90FFAB8264FFE9D1B0FFB98156FF0000000800000000000000000000
          0005C39369FFF3E4C7FFE2C9AAFFA7795AFFCFAF93FFF2DFC5FFF2DFC6FFCDAE
          92FFA17254FFDCC2A5FFEED8B6FFBE895EFF0000000700000000000000000000
          0004C99C73FFF4E6C9FFEFD7B1FFE7D2B4FFBC9577FFA97C5EFFA87B5CFFB891
          74FFE4CFB1FFEED6B1FFF1DBB6FFC49267FF0000000700000000000000000000
          0004CDA27AFFF6EACFFFF6EAD0FFF8EDD6FFF9EEDBFFF6EEDDFFF6EFDDFFF7ED
          DAFFF7ECD5FFF7EAD0FFF7EACFFFC7996FFF0000000600000000000000000000
          0003CFA880FFC39269FFC39269FFC39269FFC39269FFC39269FFC39269FFC392
          69FFC39269FFC39269FFC39269FFCB9F75FF0000000500000000000000000000
          0002D4B08BFFE4CFBEFFFEFEFEFFFDFCFCFFFCFAF9FFFAF8F6FFF8F5F3FFF7F2
          F0FFF6F0ECFFF4EDE9FFF2ECE7FFD1A981FF0000000400000000000000000000
          00019F876ABFD7B58FFFD6B48FFFD6B38FFFD6B28FFFD6B28EFFD5B18DFFD6B0
          8CFFD5B08BFFD4AF8AFFD4AF8AFF9D8266C00000000300000000000000000000
          0000000000010000000200000002000000020000000200000003000000030000
          0003000000030000000300000003000000020000000100000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000001000000070000000D0000001100000012000000110000
          000D000000070000000100000000000000000000000000000000000000000000
          0001000000040000000D09053B6915097EC2190CA4EF1D0CB2FF180BA3EF1408
          7EC209043A6A0000000E00000004000000010000000000000000000000010000
          000503020F27170E7CBC201AC3FF1D2CE3FF1B34F4FF1B35FBFF1A31F4FF1B27
          E3FF1C16C1FF150A7ABD02010F29000000050000000100000000000000040504
          1A352319ABEB242EDCFF223FFBFF203DFCFF1F3CFBFF1F3AFBFF1E3AFBFF1D3A
          FAFF1D36F8FF1E27DAFF1E12A7EC0302112B000000040000000001000210231A
          9BD72B38E3FF2A47FDFF2744FDFF2642FCFF2542FBFF2441FBFF2341FCFF2240
          FBFF213EFBFF213BFBFF212DE1FF190F7EBB0000000D00000001120F476C3332
          D1FF2F4CFEFF2E4DFDFF2E4BFDFF2C49FCFF2C48FCFF2A48FDFF2A47FDFF2946
          FCFF2543FCFF2542FBFF2441FBFF2928CBFF0E0940690000000525218DBD3949
          EBFF3552FDFF3553FFFF3350FFFF324FFEFF304DFEFF2F4CFEFF2E4BFDFF2D4A
          FDFF2D48FCFF2C48FCFF2B45FDFF2D3BE7FF1F1887BF0000000A362FBCED3C55
          FAFF3C57FFFF3958FFFF3755FEFF3755FEFF3653FEFF3553FFFF3451FFFF3350
          FFFF324FFFFF304DFEFF2F4CFEFF2F48F7FF2C25B2EB0000000B3F3BD1FF4561
          FEFF415EFFFF405EFFFF3E5CFFFF3D5AFFFF3C5AFFFF3A57FFFF3A57FFFF3956
          FEFF3855FFFF3653FEFF3552FDFF3753FEFF342FC3FA0000000B3E3DC2EC526C
          FAFF4664FFFF4663FFFF4561FFFF4361FFFF415EFFFF415EFFFF405DFFFF3E5B
          FFFF3D5AFFFF3C59FFFF3A57FFFF435EFAFF3630BAEA0000000A333499BA5A6D
          F1FF4D6AFFFF4C68FFFF4B67FFFF4A66FFFF4965FFFF4764FFFF4563FFFF4561
          FFFF4360FFFF425FFFFF405EFFFF5060EFFF2E2B93BC000000071B1B4E62555C
          E5FF5F7BFFFF506DFFFF4F6DFFFF4E6AFFFF4E68FFFF4C69FFFF4B68FFFF4A68
          FFFF4A66FFFF4866FFFF5571FFFF4E52E0FF1817496200000003010103094042
          B3D06474F1FF6480FFFF5472FFFF526FFFFF526EFFFF526EFFFF516EFFFF4F6D
          FFFF4F6BFFFF5D79FFFF5D6DF0FF323294B50000000700000001000000010C0C
          202A4C51CEEA6372F0FF708BFEFF607DFFFF5976FFFF5572FFFF5873FFFF5D7A
          FFFF6B85FEFF606DEEFF474AC9E9070715200000000200000000000000000000
          00010707131B3B3D9CB25D64E9FF6C80F6FF758CFCFF7791FFFF738CFCFF6B7E
          F6FF5960E7FF383A9AB30707131C000000020000000000000000000000000000
          000000000001000000031A1B44503335889B4548B5CC5559E1F94447B4CC3235
          879B191A43510000000400000001000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00020000000900000012000000180000001A0000001A00000018000000100000
          0005000000010000000000000000000000000000000000000000000000020000
          000D3524146A936338E5A56B3AFFA36938FFA16736FF9D6233FB633E20B70805
          022800000006000000010000000000000000000000000000000000000008442F
          1D78C18B59FEE1AC76FFE4C296FFB5793BFFB5793CFFB5793CFFAD7239FF7E50
          2AD80302042A00000006000000010000000000000000000000000000000DB07D
          4EF3E6B17AFFE9B47DFFE9B47DFFE7C79DFFB67A3DFFB57A3DFFB57A3DFF6953
          7BFF090E5ED50001052800000006000000010000000000000000000000086A4E
          329DEFD7B3FFE9B47DFFE9B47DFFE9B47DFFEACDA4FFB57B3EFF735C86FF313F
          CCFF2935B8FF0B1161D501010627000000050000000100000000000000010000
          000C745538A5F2DDBBFFE9B47DFFE9B47DFFE9B47DFFD1CEE1FF3443CEFF3443
          CDFF3443CEFF2C39BAFF0D1463D4010106260000000500000001000000000000
          00020000000B76583BA4F5E2C1FFE9B47DFFB5A9B8FF829FF1FFB1C9F5FF3949
          D1FF3A4AD1FF3A49D1FF303FBDFF111767D30101062500000005000000000000
          0000000000010000000B785B3DA3E9E1D2FF87A3F2FF87A4F1FF87A3F2FFB9D0
          F7FF3E50D5FF3E50D5FF3F50D5FF3545C2FF141B6AD201010622000000000000
          000000000000000000010000000A2C386FA2C9E2F9FF8CA8F3FF8DA8F3FF8CA8
          F3FFC0D8F9FF4457D9FF4356D9FF4456D9FF3949C2FF141A61C2000000000000
          000000000000000000000000000100000009303D74A1CFE7FBFF92ADF3FF91AD
          F4FF92ADF4FFC6DEFAFF495EDBFF495DDCFF475AD7FF232F8BF0000000000000
          00000000000000000000000000000000000100000008334177A0D4ECFCFF97B2
          F5FF97B2F4FF97B3F5FFCCE4FBFF4A5FDAFF3141A4F6090C214A000000000000
          000000000000000000000000000000000000000000010000000736457A9FD8F0
          FDFF9DB7F5FF9CB7F5FFD9F1FEFF6B81CAF50B0E234700000006000000000000
          0000000000000000000000000000000000000000000000000001000000063947
          7D9EDBF3FEFFDBF3FFFF677FCFF513192C440000000500000001000000000000
          0000000000000000000000000000000000000000000000000000000000010000
          00053543728E4F63AACD151A2D40000000040000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0001000000030000000400000002000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000002000000070000
          000A0000000A0000000A0000000A0000000A0000000700000002000000000000
          00000000000000000000000000000000000000000000000000050000000E0000
          0013000000130000001300000013000000130000000E00000005000000000000
          0000000000000000000000000000000000000000000000000002896154FF8961
          54FF896154FF896154FF896154FF896154FF896154FF00000005000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000050000000E00000013000000130000000E00000005000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000005BA9182FFBA9182FFBA9182FFBA9182FF00000005000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000050000000E00000013000000130000000E00000005000000000000
          0000000000020000000600000008000000060000000200000002000000070000
          000A0000000CBA9182FFBA9182FFBA9182FFBA9182FF00000005000000000000
          000000000006000000120000001A0000001200000006000000050000000E0000
          0013000000130000001300000013000000130000000E00000005000000020000
          00060000000F16412FBB1F5D43FF16412FBB0000000F00000008896154FF8961
          54FF896154FF896154FF896154FF896154FF896154FF00000005000000060000
          00120000001E24654AFF4FC59EFF24654AFF0000001E00000012000000060000
          0000000000050000000E00000013000000130000000E00000005000000081C4C
          39BA296D52FF296D52FF60CEAAFF296D52FF296D52FF1C4C39BA000000080000
          000000000005BA9182FFBA9182FFBA9182FFBA9182FF00000005000000062F77
          5AFFAAEDDBFF73D6B7FF73D6B7FF73D6B7FF73D6B7FF2F775AFF000000060000
          0000000000050000000E00000013000000130000000E00000005000000022459
          44B4347F62FF347F62FF84DFC3FF347F62FF347F62FF245944B5000000090000
          000A0000000CBA9182FFBA9182FFBA9182FFBA9182FF00000005000000000000
          000000000006398769FFAAEDDBFF398769FF00000006000000050000000E0000
          0013000000130000001300000013000000130000000E00000005000000000000
          0000000000022A614DB43C8C6EFF2A614DB40000000200000002896154FF8961
          54FF896154FF896154FF896154FF896154FF896154FF00000002}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000002000000070000
          000A0000000A0000000A0000000A0000000A0000000700000002000000000000
          00000000000000000000000000000000000000000000000000050000000E0000
          0013000000130000001300000013000000130000000E00000005000000000000
          0000000000000000000000000000000000000000000000000002896154FF8961
          54FF896154FF896154FF896154FF896154FF896154FF00000005000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000050000000E00000013000000130000000E00000005000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000005BA9182FFBA9182FFBA9182FFBA9182FF00000005000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000050000000E00000013000000130000000E00000005000000000000
          0000000000000000000000000000000000000000000000000002000000070000
          000A0000000CBA9182FFBA9182FFBA9182FFBA9182FF00000005000000000000
          00000000000000000000000000000000000000000000000000050000000E0000
          0013000000130000001300000013000000130000000E00000005000000020000
          0006000000090000000A0000000A0000000A0000000900000008896154FF8961
          54FF896154FF896154FF896154FF896154FF896154FF00000005000000060000
          00120000001B0000001C0000001C0000001C0000001B00000012000000060000
          0000000000050000000E00000013000000130000000E00000005000000082728
          85BA383ABFFF383ABFFF383ABFFF383ABFFF383ABFFF272885BA000000080000
          000000000005BA9182FFBA9182FFBA9182FFBA9182FF0000000500000006494A
          C8FF7C97F0FF7C97F0FF7C97F0FF7C97F0FF7C97F0FF494AC8FF000000060000
          0000000000050000000E00000013000000130000000E00000005000000023B3C
          91B45556CFFF5556CFFF5556CFFF5556CFFF5556CFFF3B3C8FB5000000090000
          000A0000000CBA9182FFBA9182FFBA9182FFBA9182FF00000005000000000000
          00000000000000000000000000000000000000000000000000050000000E0000
          0013000000130000001300000013000000130000000E00000005000000000000
          0000000000000000000000000000000000000000000000000002896154FF8961
          54FF896154FF896154FF896154FF896154FF896154FF00000002}
      end>
  end
  object frxReport1: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44748.617040636600000000
    ReportOptions.LastChange = 44753.596252013890000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '  objVenda: TFatEmitirVenda;'
      'begin                       '
      '  objVenda := TFatEmitirVenda.Create;'
      '  Try'
      '    objVenda.strCliente := '#39'01010001'#39';                 '
      '    objVenda.AdicionarItem('#39'01020'#39');'
      '    objVenda.AdicionarItem('#39'01540'#39');'
      '    objVenda.AdicionarItem('#39'01670'#39');'
      '    if objVenda.GravarVenda() then'
      '      showMessage('#39'Gravou'#39')'
      '    else'
      '      showMessage('#39'N'#227'o gravou'#39')'
      '  Finally'
      '    objVenda.Free;      '
      '  End;'
      '                                        '
      'end.'
      '')
    Left = 304
    Top = 144
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
    end
  end
  object fsTreeIcons: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 17826016
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000060D17261737
          64B70A182D6B0001021A0000000C000000040000000100000000000000000000
          0000000000000000000000000000000000000000000000000000274776CE2A5D
          9EFF5180B6FF1F4986F111274BA5050B15460000001400000009000000020000
          0000000000000000000000000000000000000000000000000000284B7AD2295E
          A0FFA6CEE8FF75C2EBFF3A85C1FF265799FF173569DB0C1A328B0203072E0000
          0010000000060000000100000000000000000000000000000000294D7CD23467
          A8FF8DB4D8FF99DAF7FF58BCEFFF4CB1EBFF378FCFFF2664A6FF1F407DFB1223
          4BBF070D1C65000000190000000B0000000300000000000000002A4F7FD24678
          B1FF6E9AC7FFB5E5FAFF5FC2F1FF52B6ECFF44AAE6FF389CDFFF2C8DD5FF2069
          B1FF1C498CFF182E63ED0D18359E03050B3300000005000000002A5282D2628F
          BEFF4C7EB7FFD0EFFCFF64C6F3FF59BDEFFF4CB1EAFF3EA3E2FF3296DCFF2789
          D5FF1E7ECFFF186DBEFF175099FF18336EF703060D37000000022A5384D288AD
          D1FF2D67ACFFDAF2FCFF7CD2F5FF5FC3F2FF54B9EDFF46ABE6FF399CDFFF2D90
          D9FF2285D2FF1B79CDFF1572C7FF164991FF0B132B86000000072C5586D2A5C5
          DEFF3675B4FFC0DAEDFFA0DFF9FF65C8F3FF5ABEF1FF4DB2EAFF3FA5E3FF3498
          DCFF288CD7FF2080D0FF1977CBFF1659A6FF111F43BB0000000C2C5689D2BAD5
          E8FF589CCEFF8DB2D6FFC6EDFCFF91D8F8FF69C7F3FF56BBEFFF48ADE7FF3BA0
          E0FF2F93DBFF2487D4FF1D7ECFFF186CBDFF172C5EE7000000132C598AD2C7DC
          ECFF7FC7E7FF5688BEFFA1C1DFFFCEE7F6FFD0EEFCFFABDFF8FF81CAF1FF57B0
          E8FF379CDFFF2B8FD8FF2384D3FF1A79CDFF1C3A77FD020306282E5C8ED2D1E3
          F0FFA3E8FDFF6DBBE2FF4A91C7FF2D69ADFF4B7CB5FF77A1CBFF9BC4E3FFAADA
          F5FF8DCAEFFF5DADE4FF3995DBFF2082D2FF1C498EFF080E1E60316091D2D5E4
          F1FFF0FCFFFFD0F4FFFFA9EBFDFF8CE2FDFF8FCBE9FF76A5CFFF3F76AFFF3261
          9FFF5E8CBDFF76ABD7FF7BBCE9FF60A9E2FF2B64A7FF0E1B3892172C425D3C71
          A7ED79A1C9FFBBD3E6FFE8F8FDFF91B4D3FF4573A8FF779FC4FFAED3E8FFB1DD
          F2FF6CA1CBFF386CA7FF2B5594FF4476AEFF4C88C2FF142953BC000000000203
          040615283B542C537CB43D71A9F91E395784050A0F18162B436C294D7BCC4B75
          A6FF7DA7CAFFA8DAF0FF6D9EC4FF1C3868C4173263C31B3770E7000000000000
          0000000000000000000001010203000000000000000000000000000000000810
          192A1A314F872B5183E75681ADFF1B3051960000000000010103000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000E1A2A4B080F192D0000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000000000000000000001000000050000000C050D1F520E28
          5DCD113379FF0D275CCD040C1E520000000D0000000500000001000000020000
          00070000000B0000000C0000000C00000011050F2157112E63CF275DA0FF4DA4
          E0FFC1E6F9FF275DA3FF194389FF0E295ECD040D1E5000000005000000062D25
          7ABE3F32A9FF3E32A9FF3D31A8FF3A2DA0FF1F5095FF5BAFE6FF6FCBFFFF6ECC
          FFFFCDECFAFF2F6DB2FF306DB3FF2A64AAFF163E84FF0000000A000000094439
          ADFF6373DEFF5566DAFF5464D9FF4E5FD0FF245B9EFF7ED2FFFF7ED4FFFF7ED4
          FFFFDAF0FBFF3272B6FF3172B5FF3172B6FF19458AFF0000000C00000009483F
          B1FF6D7DE1FF596ADBFF5869DBFF5364D2FF2963A7FF8EDBFFFF8EDBFFFF8EDB
          FFFFE5F5FCFF3476B8FF3475B8FF3376B8FF1D4D91FF0000000B000000084D44
          B5FF7787E3FF5E6FDDFF5C6EDCFF5868D4FF2C6CAEFF9DE1FFFF9DE1FFFF9CE1
          FFFFF0F9FEFF3578BAFF3578BAFF3578BAFF215599FF0000000A000000075149
          B8FF8192E6FF6274DEFF6173DEFF5C6DD6FF2F73B4FFABE6FFFFC6EFFFFFF0FB
          FFFFFFFFFFFFE9F4FBFF81AFD7FF3578BAFF245C9FFF0000000900000007564F
          BDFF8C9BE9FF6679E0FF6578DFFF6272D9FF3074B6FFC2DAEDFFF2FCFFFFD6F3
          FDFFC7EFFCFFD1F1FDFFF0FAFEFFBBD4EAFF2862A5FF00000006000000065A54
          C0FF95A3ECFF6B7EE1FF6F81E3FF6E81E1FF5E7CD2FF3E75BDFF5491C7FFA2D1
          EBFFC6EFFCFF9FCFEBFF5290C6FF245789C70A17274400000002000000055F5A
          C4FFA0AFEFFF798DE5FF7A8EE6FF788BE5FF778AE3FF7388E1FF6280D4FF3F77
          BEFF3074B6FF4279BEFF4955B4FF0000000D0000000200000000000000056561
          C8FFB0BEF2FF8196E8FF8095E8FF7F93E8FF7D92E7FF7D91E8FF7B8FE5FF788D
          E3FF768CE2FF8EA0E8FF5B55C0FF000000070000000000000000000000046D6B
          CFFFB8C7F4FF879CEAFF869BEAFF859AE9FF8399E9FF8398E9FF8297E9FF8195
          E8FF8094E8FF97AAEDFF6360C6FF000000070000000000000000000000047271
          D1FFBFCCF5FFBECCF6FFBCCBF5FFBCCBF5FFBBCAF5FFBACAF5FFBAC8F5FFB9C8
          F4FFB8C6F4FFB7C5F4FF6A66CBFF000000060000000000000000000000037777
          D6FF7576D7FF7474D5FF7171D4FF6F6ED2FF6D6CD0FF6B68CEFF6966CCFF6663
          CAFF6360C8FF615DC7FF6F6CCEFF000000050000000000000000000000028282
          DBFFC5C5EFFFFEFEFEFFFDFCFCFFFCFAF9FFFAF8F6FFF8F5F3FFF7F2F0FFF6F0
          ECFFF4EDE9FFF2ECE7FF7979D4FF000000040000000000000000000000016264
          A6BF8587E0FF8486DFFF8485DFFF8385DDFF8284DEFF8284DCFF8283DCFF8083
          DCFF8082DCFF8081DBFF5E5FA2C0000000030000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CAB9D60072247100BEAF
          CA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CDBFD700A950A80080307F007527
          7500BFB0CD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00CDBCD700AA50A900CC67CB007E2E7E009638
          95007B2B7A00C0B2CE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00CEB8D600A950A800D36BD200D46ED3007F307E009F3C
          9F008E358D007D2D7C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00AA52A900D26AD100D56FD500BD70BC00DE98DD008F46
          8E009D3C9C007E2E7E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00A84FA700D26DD100BC6FBB00EFA5EE00FB9FFA00EF9D
          EE00975296007C2E7C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00A750A600BC6FBB00EFA5EE00FB9BFA00FB98FA00FB99
          FA00E798E600914E9000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00CF88CF00E2AFE200FBABFA00FB98FA00FB98FA00EA90
          E900CF88CF00C1C0D000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00DEC6E500CF88CF00EEBEEE00FBAEFA00EC91EB00CF88
          CF00C7C1D500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00DBC8E300CF88CF00E3ACE300CF88CF00C9C4
          D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D7C7E000CF88CF00CAC6D600FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        MaskColor = clWhite
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D8C9B60099330000BEA59700FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00DBCAB600D79A5A009933000099330000BDA9
          9C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00D79A5A00D89B5B0099330000993300009933
          0000BAA69A00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00D89B5B00D89B5B00D89B5B0099330000993300009933
          000099330000B8AA9F00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00D89B5B00D89B5B00E9B47C00FCD6AF00B56335009933
          00009933000099330000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00D89B5B00EAB78200FBD8B200FED1A300FBD8B200AF57
          28009933000099330000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00E7B37C00F1C39100FECF9D00FFCD9900FED09F00FBD8
          B200A94E1E0099330000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00EADBCA00E5B27B00F4C08B00FFCD9900FFCD9900FED0
          A100F2C99D00B05A2900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00EADBC900E4B07900F6C49000FFCD9900F3C2
          8E00E3B07900D9CEBC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7D5C100E3AF7800EEBD8A00E3B0
          7900D5D1C400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E0D3C200E5B27D00D4D4
          CC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        MaskColor = clWhite
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF006F6363003E3834006D635A00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF0090989000ABAEB0000E0D0C007D716700FFFFFF00B8C5C700FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00867A7B000E0D0C00FFFFFF002C2926002E2F25008B7B
          6D001E1A17000E0C0A002B201500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00B5A9A000000000007D706600FFFFFF00B8C5C7006154
          5400000000004B413900ABAEB000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00B8C5C700505050003E373200FFFFFF00C3C9CC008E89
          7B00202020000E0C0A00B8C5C700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00787675000E0D0C00FFFFFF00968B80009694
          9300A3978600928073001D1915003B312A00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF007C7E740000000000B8C5C700FFFFFF00B8C5
          C700ABAEB000FFFFFF00ABAEB000ABAEB000FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00ACA29900201820007D706400FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00AA9E9400B0B0B000808080001008100010080000FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00969C93001E221800B8C5C700FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BFB3AA0060606000ABAEB0003A2F
          240057483A00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B0ABA700786F75001D14
          0B003D3B2E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B8C5
          C700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        MaskColor = clWhite
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0A090006048
          3000604830006048300060483000604830006048300060483000604830006048
          30006048300060483000604830006048300060483000FFFFFF00C0A89000FFFF
          FF00E0E0E000E0D8D000E0D8D000E0D0D000E0D0C000E0D0C000E0D0C000E0C8
          B000E0C8B000E0C8B000E0C8B000E0C0B00060483000FFFFFF00C0A8A000FFF8
          FF00817B7500FFF8F0007F7A7400FFF0F0007C77710079746E0074706A00FFE8
          E0006A65600064605C00605D5800E0C0B00060483000FFFFFF00C0A8A000FFFF
          FF00817B75007F7B75007F7A7400FFF8F0007C777100FFF8F00075706B00FFF0
          E0006C676200FFE8E000FFE8E000E0C0B00060483000FFFFFF00D0B0A000FFFF
          FF00807B7500FFFFFF007F7A7400FFF8F0007D7872007B756F0076726C00FFF0
          F0006E696400FFF0E000FFF0E000E0C8B00060483000FFFFFF00D0B8A000FFFF
          FF00FFF8F000807B7500807A7400FFF8F0007E7872007D777100FFF8F000FFF8
          F000726C67006D69640069646000F0D8D00060483000FFFFFF00D0B8A000FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF8F000FFF8F000FFF8F000FFF8
          F000FFF0F000FFF0F000FFF0F000FFE8D00060483000FFFFFF00D0B8A000D0B8
          A000D0B8A000D0B8A000D0B8A000D0B8A000D0B8A000D0B8A000D0B8A000D0B8
          A000D0B8A000D0B8A000D0B8A000D0B8A000D0B8A000FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        MaskColor = clWhite
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000008D69
          5DC3B78576FFB48173FFB27E6EFFAF7A6AFFAE7868FFAE7766FFAD7463FFAC72
          60FFAB705EFFAA6E5CFFAA6E5CFFAA6E5CFF835547C40000000000000000BB8D
          7FFFFBF4F1FFF7F0EDFFEFE8E6FFEAE3E0FFEFE8E4FFF4ECE9FFF4ECE8FFF2E9
          E6FFF2E9E6FFF4EBE7FFF7EEEAFFF9F0ECFFAA6E5CFF0000000000000000BE91
          84FFFBF4F2FFF6EFECFFA7938CFF6F4F45FFA7938CFFF2EAE6FFF0E8E5FFECE5
          E1FFECE4E1FFEFE7E3FFF6EDE9FFF9F0ECFFAA6E5CFF0000000000000000C096
          89FFFBF5F3FFF8F1EFFF735347FFF8F1EFFF76564BFFF5EDEAFF755447FF7554
          47FF755447FF755447FFF7EEEAFFF9F0ECFFAB705EFF0000000000000000C39A
          8DFFFBF5F4FFF9F3F1FFB29E96FF7B5B4FFFB29D95FFF8F1EEFFFAF2EFFFFAF2
          EFFFFAF1EEFFF9F1EDFFF9F1EDFFF9F0ECFFAC7261FF0000000000000000C59E
          92FFFCF6F5FFF8F3F1FFF0EAE9FFEBE6E4FFF0E9E8FFF6EFECFFF5EEEBFFF3EC
          E9FFF3EBE8FFF5EDE9FFF7EFECFFF9F1EDFFAE7564FF0000000000000000C7A2
          97FFFCF6F5FFF7F1F0FFA8958EFF6F5045FFA8948DFFF3ECEAFFF1EAE8FFEDE7
          E5FFEDE7E4FFF0E9E6FFF7EFEBFFFAF1EEFFB07867FF0000000000000000CAA6
          9BFFFCF7F6FFF9F4F2FF735347FF704F43FF76564BFFF6F0EEFF755447FF7554
          47FF755447FF755447FFF8F0EDFFFAF2EFFFB27C6BFF0000000000000000CCAA
          9FFFFCF7F6FFFBF6F5FFB4A199FF7B5B4FFFB4A099FFFAF5F3FFFBF5F3FFFBF5
          F3FFFBF4F2FFFBF4F1FFFAF3F0FFFAF2F0FFB47F70FF0000000000000000CDAD
          A3FFFCF7F6FFFCF7F6FFFCF7F6FFFCF7F6FFFCF6F5FFFCF6F5FFFBF6F4FFFBF5
          F3FFFBF5F3FFFBF4F2FFFBF4F1FFFAF3F0FFB68374FF0000000000000000C990
          5BFFC9905BFFC9905BFFC9905BFFC9905BFFC9905BFFC9905BFFC9905BFFC990
          5BFFC9905BFFC9905BFFC9905BFFC9905BFFC9905BFF0000000000000000C990
          5BFFE4BA83FFE4BA83FFE4BA83FFE4BA83FFE4BA83FFE4BA83FFE4BA83FFE4BA
          83FFE4BA83FFE4BA83FFE4BA83FFE4BA83FFC9905BFF0000000000000000C990
          5BFFE5BD87FFE5BD87FFE5BD87FFE5BD87FFE5BD87FFE5BD87FFE5BD87FFE5BD
          87FFE5BD87FFE5BD87FFE5BD87FFE5BD87FFC9905BFF0000000000000000C08F
          65F1C9905BFFC9905BFFC9905BFFC9905BFFC9905BFFC9905BFFC9905BFFC990
          5BFFC9905BFFC9905BFFC9905BFFC9905BFFBC895FF100000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end>
  end
  object appEvents: TApplicationEvents
    Left = 214
    Top = 166
  end
  object tmrFilterTree: TTimer
    Enabled = False
    Interval = 300
    OnTimer = tmrFilterTreeTimer
    Left = 964
    Top = 100
  end
end
