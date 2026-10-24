inherited frmCadOpeConfig: TfrmCadOpeConfig
  Left = 414
  Top = 211
  Width = 483
  Height = 423
  Caption = 'Configura'#231#245'es Mobile'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 483
  ExplicitHeight = 423
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 351
    Width = 477
    TabOrder = 2
    ExplicitTop = 351
    ExplicitWidth = 477
    DesignSize = (
      477
      28)
    inherited btnSair: TBitBtnLocked
      Left = 394
      TabOrder = 1
      ExplicitLeft = 394
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 77
      Height = 22
      Caption = '&Confirma'
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
  end
  object pnlTopo: TPanel [2]
    Left = 0
    Top = 0
    Width = 477
    Height = 103
    Align = alTop
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 12
      Width = 118
      Height = 14
      Alignment = taRightJustify
      Caption = 'Dias Prazo Faturamento:'
    end
    object dbReplicarPedido: TDBCheckBox
      Left = 128
      Top = 32
      Width = 97
      Height = 17
      Caption = 'Replicar Pedido'
      TabOrder = 2
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object dbReplicarHistPedido: TDBCheckBox
      Left = 128
      Top = 48
      Width = 161
      Height = 17
      Caption = 'Replicar Hist'#243'rico do Pedido'
      TabOrder = 3
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object dbAlterarPlanoVisita: TDBCheckBox
      Left = 128
      Top = 64
      Width = 137
      Height = 17
      Caption = 'Alterar Plano de Visitas'
      TabOrder = 4
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object dbPoliticaVenda: TDBRadioGroup
      Left = 296
      Top = 8
      Width = 169
      Height = 73
      Caption = 'Pol'#237'tica de Venda'
      Items.Strings = (
        'Negocia'#231#227'o para Desconto'
        'Negocia'#231#227'o para Margem'
        'Ambos')
      TabOrder = 1
      Values.Strings = (
        '1'
        '2'
        '3')
      OnChange = dbPoliticaVendaChange
    end
    object dbDiasPrazoFaturamento: TDBEditFocus
      Tag = 99
      Left = 128
      Top = 8
      Width = 33
      Height = 22
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbExcedMargem: TDBCheckBox
      Left = 297
      Top = 82
      Width = 169
      Height = 17
      Caption = 'Exceder a Margem'
      TabOrder = 6
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object dbeCndPag: TDBCheckBox
      Left = 128
      Top = 81
      Width = 169
      Height = 17
      Caption = 'Liberar Todas Cnd.Pagtos'
      TabOrder = 5
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 103
    Width = 477
    Height = 58
    Align = alTop
    Color = 16770261
    TabOrder = 1
    object Label3: TLabel
      Left = 11
      Top = 34
      Width = 115
      Height = 14
      Alignment = taRightJustify
      Caption = 'Telefone para Conex'#227'o:'
    end
    object Label2: TLabel
      Left = 74
      Top = 12
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object dbTelCon: TDBEditFocus
      Tag = 99
      Left = 128
      Top = 30
      Width = 337
      Height = 22
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescricao: TDBEditFocus
      Tag = 99
      Left = 128
      Top = 8
      Width = 337
      Height = 22
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlConex: TPanel [4]
    Left = 0
    Top = 161
    Width = 477
    Height = 190
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object pgcConexoes: TPageControl
      Left = 1
      Top = 1
      Width = 475
      Height = 188
      ActivePage = tbsPopSmtp
      Align = alClient
      HotTrack = True
      MultiLine = True
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      TabPosition = tpBottom
      object tbsPopSmtp: TTabSheet
        Caption = 'POP'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label6: TLabel
          Left = 11
          Top = 18
          Width = 67
          Height = 14
          Alignment = taRightJustify
          Caption = 'Servidor POP:'
        end
        object Label7: TLabel
          Left = 4
          Top = 40
          Width = 74
          Height = 14
          Alignment = taRightJustify
          Caption = 'Servidor SMTP:'
        end
        object Label9: TLabel
          Left = 17
          Top = 84
          Width = 61
          Height = 14
          Alignment = taRightJustify
          Caption = 'Usu'#225'rio Pop:'
        end
        object Label8: TLabel
          Left = 23
          Top = 106
          Width = 55
          Height = 14
          Alignment = taRightJustify
          Caption = 'Senha Pop:'
        end
        object Label12: TLabel
          Left = 12
          Top = 62
          Width = 66
          Height = 14
          Alignment = taRightJustify
          Caption = 'Email Destino:'
        end
        object dbeServPop: TDBEditFocus
          Tag = 99
          Left = 80
          Top = 10
          Width = 380
          Height = 22
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeServSmtp: TDBEditFocus
          Tag = 99
          Left = 80
          Top = 32
          Width = 380
          Height = 22
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeSenPop: TDBEditFocus
          Tag = 99
          Left = 80
          Top = 98
          Width = 380
          Height = 22
          PasswordChar = '*'
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeUsuPop: TDBEditFocus
          Tag = 99
          Left = 80
          Top = 76
          Width = 380
          Height = 22
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeEmailDes: TDBEditFocus
          Tag = 99
          Left = 80
          Top = 54
          Width = 380
          Height = 22
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object tbsDialUp: TTabSheet
        Caption = 'DialUp'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label4: TLabel
          Left = 5
          Top = 18
          Width = 73
          Height = 14
          Alignment = taRightJustify
          Caption = 'Usu'#225'rio DialUp:'
        end
        object Label5: TLabel
          Left = 11
          Top = 40
          Width = 67
          Height = 14
          Alignment = taRightJustify
          Caption = 'Senha DialUp:'
        end
        object dbUsuarioDial: TDBEditFocus
          Tag = 99
          Left = 80
          Top = 10
          Width = 380
          Height = 22
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbSenhaDial: TDBEditFocus
          Tag = 99
          Left = 80
          Top = 32
          Width = 380
          Height = 22
          PasswordChar = '*'
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object tbsFtp: TTabSheet
        Caption = 'FTP'
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label10: TLabel
          Left = 17
          Top = 35
          Width = 61
          Height = 14
          Alignment = taRightJustify
          Caption = 'Usu'#225'rio FTP:'
        end
        object Label11: TLabel
          Left = 23
          Top = 57
          Width = 55
          Height = 14
          Alignment = taRightJustify
          Caption = 'Senha FTP:'
        end
        object Label13: TLabel
          Left = 32
          Top = 13
          Width = 46
          Height = 14
          Alignment = taRightJustify
          Caption = 'Host FTP:'
        end
        object Label14: TLabel
          Left = 81
          Top = 73
          Width = 186
          Height = 14
          Alignment = taRightJustify
          Caption = 'Diret'#243'rio de recebimento dos arquivos:'
        end
        object Label15: TLabel
          Left = 81
          Top = 112
          Width = 153
          Height = 14
          Alignment = taRightJustify
          Caption = 'Diret'#243'rio de envio dos arquivos:'
        end
        object dbeSenFtp: TDBEditFocus
          Tag = 99
          Left = 80
          Top = 49
          Width = 380
          Height = 22
          PasswordChar = '*'
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeUsuFtp: TDBEditFocus
          Tag = 99
          Left = 80
          Top = 27
          Width = 380
          Height = 22
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeHostFtp: TDBEditFocus
          Tag = 99
          Left = 80
          Top = 5
          Width = 380
          Height = 22
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        inline fraDirRec: TfraDirectoryEditFocus
          Left = 80
          Top = 88
          Width = 380
          Height = 24
          Color = 16770261
          ParentBackground = False
          ParentColor = False
          TabOrder = 3
          ExplicitLeft = 80
          ExplicitTop = 88
          ExplicitWidth = 380
          ExplicitHeight = 24
          inherited edtDirectory: TEditFocus
            Width = 355
            Height = 22
            ExplicitWidth = 355
            ExplicitHeight = 22
          end
          inherited btnOpenDirectory: TcxButton
            Left = 357
            Height = 24
            ExplicitLeft = 357
            ExplicitHeight = 24
          end
        end
        inline fraDirEnv: TfraDirectoryEditFocus
          Left = 80
          Top = 127
          Width = 380
          Height = 24
          Color = 16770261
          ParentBackground = False
          ParentColor = False
          TabOrder = 4
          ExplicitLeft = 80
          ExplicitTop = 127
          ExplicitWidth = 380
          ExplicitHeight = 24
          inherited edtDirectory: TEditFocus
            Width = 355
            Height = 22
            ExplicitTop = 0
            ExplicitWidth = 355
            ExplicitHeight = 22
          end
          inherited btnOpenDirectory: TcxButton
            Left = 357
            Height = 24
            ExplicitLeft = 357
            ExplicitHeight = 24
          end
        end
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 378
    Width = 477
    TabOrder = 4
    ExplicitTop = 378
    ExplicitWidth = 477
    inherited pnlNomeForm: TPanel
      Left = 306
      TabOrder = 1
      ExplicitLeft = 306
    end
    inherited pnlInfo: TPanel
      Width = 306
      TabOrder = 0
      ExplicitWidth = 306
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 448
    Top = 368
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 368
    Top = 368
  end
end
