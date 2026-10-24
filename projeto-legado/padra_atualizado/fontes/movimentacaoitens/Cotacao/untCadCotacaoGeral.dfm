inherited frmCadCotacaoGeral: TfrmCadCotacaoGeral
  Left = 217
  Top = 209
  Width = 800
  Height = 532
  BorderStyle = bsSizeable
  Caption = 'Cota'#231#227'o'
  Position = poDesigned
  WindowState = wsMaximized
  OnClose = FormClose
  ExplicitWidth = 800
  ExplicitHeight = 532
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 450
    Width = 784
    TabOrder = 1
    ExplicitTop = 450
    ExplicitWidth = 784
    DesignSize = (
      784
      28)
    inherited btnSair: TBitBtnLocked
      Left = 702
      Height = 20
      ModalResult = 2
      ExplicitLeft = 702
      ExplicitHeight = 20
    end
    object btnGravar: TBitBtnLocked
      Left = 5
      Top = 3
      Width = 124
      Height = 20
      Caption = '&Gravar Cota'#231#227'o'
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
      ModalResult = 1
      TabOrder = 1
    end
  end
  inherited pnlStatus: TPanel
    Top = 478
    Width = 784
    TabOrder = 2
    ExplicitTop = 478
    ExplicitWidth = 784
    inherited pnlNomeForm: TPanel
      Left = 613
      ExplicitLeft = 613
    end
    inherited pnlInfo: TPanel
      Width = 613
      ExplicitWidth = 613
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 0
    Width = 784
    Height = 82
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 98
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero da Cota'#231#227'o:'
    end
    object Label2: TLabel
      Left = 54
      Top = 39
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 251
      Top = 16
      Width = 87
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data de Cadastro:'
    end
    object Label4: TLabel
      Left = 541
      Top = 16
      Width = 110
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data de Encerramento:'
    end
    object Label5: TLabel
      Left = 50
      Top = 62
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Comprador:'
    end
    object dbeNumCot: TDBEditFocus
      Tag = 99
      Left = 112
      Top = 8
      Width = 121
      Height = 22
      DataField = 'COT_NUMCOT'
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 112
      Top = 31
      Width = 521
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COT_DESCRI'
      MaxLength = 100
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDtaCad: TDBEditFocus
      Tag = 99
      Left = 344
      Top = 8
      Width = 97
      Height = 22
      TabStop = False
      DataField = 'COT_DTACAD'
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = True
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDtaFin: TDBEditFocus
      Tag = 99
      Left = 657
      Top = 8
      Width = 97
      Height = 22
      TabStop = False
      DataField = 'COT_DTAFIN'
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = True
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtNomCmp: TEditFocus
      Left = 186
      Top = 54
      Width = 255
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtCodCmp: TEditFocus
      Tag = 99
      Left = 112
      Top = 54
      Width = 73
      Height = 22
      Alignment = taLeftJustify
      AutoSize = False
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 40
      PasswordChar = '*'
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeMulLoj: TDBCheckBox
      Left = 639
      Top = 36
      Width = 114
      Height = 17
      BiDiMode = bdRightToLeft
      Caption = 'Cota'#231#227'o Multi-lojas'
      DataField = 'COT_MULLOJ'
      ParentBiDiMode = False
      TabOrder = 4
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = dbeMulLojClick
    end
  end
  object pnlInfCot: TPanel [3]
    Left = 0
    Top = 82
    Width = 784
    Height = 368
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object pagCotacao: TPageControl
      Left = 0
      Top = 0
      Width = 784
      Height = 368
      ActivePage = tabAtualizaPreco
      Align = alClient
      TabOrder = 0
      OnChange = pagCotacaoChange
      OnChanging = pagCotacaoChanging
      OnEnter = pagCotacaoEnter
      object TabSheet2: TTabSheet
        Caption = '&1- Itens'
        ImageIndex = 1
        object pnlItens: TPanel
          Left = 0
          Top = 0
          Width = 776
          Height = 339
          Align = alClient
          DockSite = True
          ParentColor = True
          TabOrder = 0
        end
      end
      object TabSheet1: TTabSheet
        Caption = '&2- Fornecedores'
        object pnlFornecedores: TPanel
          Left = 0
          Top = 0
          Width = 776
          Height = 339
          Align = alClient
          DockSite = True
          ParentColor = True
          TabOrder = 0
        end
      end
      object tabCotForIte: TTabSheet
        Caption = '&3- Cota'#231#227'o por Fornecedor'
        ImageIndex = 2
        object pnlCotFornecedor: TPanel
          Left = 0
          Top = 0
          Width = 776
          Height = 339
          Align = alClient
          DockSite = True
          ParentColor = True
          TabOrder = 0
        end
      end
      object TabSheet4: TTabSheet
        Caption = '&4- Comparativo'
        ImageIndex = 3
        object pnlComparativo: TPanel
          Left = 0
          Top = 0
          Width = 776
          Height = 339
          Align = alClient
          DockSite = True
          ParentColor = True
          TabOrder = 0
        end
      end
      object tabAtualizaPreco: TTabSheet
        Caption = '&5-Atualiza'#231#227'o de Pre'#231'os'
        ImageIndex = 4
        object pnlAtuPrecos: TPanel
          Left = 0
          Top = 0
          Width = 776
          Height = 339
          Align = alClient
          DockSite = True
          ParentColor = True
          TabOrder = 0
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 568
    Top = 176
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 648
    Top = 184
  end
end
