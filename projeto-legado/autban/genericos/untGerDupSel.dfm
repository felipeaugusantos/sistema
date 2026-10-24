inherited frmGerDupSel: TfrmGerDupSel
  Left = 267
  Top = 148
  Width = 927
  Height = 549
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'frmGerDupSel'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 927
  ExplicitHeight = 549
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 484
    Width = 927
    Height = 49
    ExplicitTop = 484
    ExplicitWidth = 927
    ExplicitHeight = 49
    DesignSize = (
      927
      49)
    inherited FlwBotoes: TFlowPanel
      Width = 923
      Height = 45
      ExplicitWidth = 923
      ExplicitHeight = 45
      object btnOrdem: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 150
        Height = 22
        Caption = '[ F3 ] Muda Ordem'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnOrdemClick
      end
      object btnProtesta: TBitBtnLocked
        Left = 150
        Top = 0
        Width = 150
        Height = 22
        Caption = '[ F4 ] Protesta      '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = btnProtestaClick
      end
      object btnBusca: TBitBtnLocked
        Left = 300
        Top = 0
        Width = 150
        Height = 22
        Caption = '[ F5 ] Inicia Busca'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = btnBuscaClick
      end
      object btnProximo: TBitBtnLocked
        Left = 450
        Top = 0
        Width = 150
        Height = 22
        Caption = '[ F6 ] Localiza Pr'#243'ximo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = btnProximoClick
      end
      object btnSelTodos: TBitBtnLocked
        Left = 600
        Top = 0
        Width = 150
        Height = 22
        Caption = '[ F7 ] Marcar Todos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = btnSelTodosClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 750
        Top = 0
        Width = 150
        Height = 22
        Caption = '[ F8 ] Desmarcar Todos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = btnDesmarcaTodosClick
      end
      object btnVerCred: TBitBtnLocked
        Left = 0
        Top = 22
        Width = 150
        Height = 22
        Caption = '[ F9 ] Ver Cr'#233'ditos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = btnVerCredClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 150
        Top = 22
        Width = 150
        Height = 22
        Caption = '[ F10 ] Confirma'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        OnClick = btnConfirmaClick
      end
      object btnProtestaTodas: TBitBtnLocked
        Left = 300
        Top = 22
        Width = 150
        Height = 22
        Caption = '[ F11 ] Protesta Todas     '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        OnClick = btnProtestaTodasClick
      end
      object btnDigVal: TBitBtnLocked
        Left = 450
        Top = 22
        Width = 150
        Height = 22
        Caption = '[ F12 ] Valor Para Sele'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        OnClick = btnDigValClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 752
      Top = 24
      Width = 150
      Caption = '[Esc] Sair'
      ExplicitLeft = 752
      ExplicitTop = 24
      ExplicitWidth = 150
    end
  end
  inherited pnlStatus: TPanel
    Top = 533
    Width = 927
    ExplicitTop = 533
    ExplicitWidth = 927
    inherited pnlNomeForm: TPanel
      Left = 756
      ExplicitLeft = 756
    end
    inherited pnlInfo: TPanel
      Width = 756
      ExplicitWidth = 756
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 927
    Height = 484
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    object pnlTopo: TPanel
      Left = 0
      Top = 0
      Width = 927
      Height = 22
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Caption = 'Sele'#231#227'o de Duplicatas'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 17
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
    end
    object pnlDadosDup: TPanel
      Left = 522
      Top = 22
      Width = 405
      Height = 462
      Align = alRight
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object lblCliente: TLabel
        Left = 34
        Top = 23
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
        Left = 39
        Top = 44
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
        Left = 25
        Top = 149
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
        Left = 39
        Top = 170
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
        Left = 15
        Top = 191
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
        Left = 24
        Top = 212
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
        Left = 26
        Top = 313
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
      object Label1: TLabel
        Left = 14
        Top = 273
        Width = 55
        Height = 14
        Alignment = taRightJustify
        Caption = 'Doc Antigo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 20
        Top = 65
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'Endere'#231'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 37
        Top = 86
        Width = 32
        Height = 14
        Alignment = taRightJustify
        Caption = 'Bairro:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 33
        Top = 107
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cidade:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 47
        Top = 128
        Width = 22
        Height = 14
        Alignment = taRightJustify
        Caption = 'CEP:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblLinDig: TLabel
        Left = 6
        Top = 354
        Width = 63
        Height = 14
        Alignment = taRightJustify
        Caption = 'Lin. Digit'#225'vel:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblCodBar: TLabel
        Left = 8
        Top = 333
        Width = 61
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'd. Barras:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object spbAmpliar: TSpeedButton
        Left = 379
        Top = 212
        Width = 23
        Height = 22
        Hint = 'Visualizar hist'#243'rico completo'
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000020000000E0B14308329448DFB1D2F58A5000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000020000000E0D1937883C6DB2FF5BB1F9FF325196F4000000000000
          00000000000100000004000000090000000D0000000F0000000F0000000C0000
          00070000000E0F1D3C864A7CBCFF73C4FFFF467CC3FF17254485000000000000
          0002000000081C130F465A3B31BC7C5043F87F5244FF7B4E42FA57382FC11E14
          1059112142875686C2FF88D0FFFF5186C7FF142343880000000F000000010302
          02104A332C91946B5DFDC6ACA1FFE4D1C6FFEDDDD2FFE2D0C5FFC0A599FF855C
          50FF6E6B7EFF98D4F8FF5B8ECBFF152545840000000D00000002000000076046
          3DA6B39288FFE9DAD0FFDAC0A1FFCBA87AFFC49B66FFCCAA7EFFDCC2A5FFE5D2
          C6FF9A766AFF736A77FF162747850000000E00000002000000002A201D4AAE88
          7CFFEFE6DFFFCDA67CFFCDA36EFFE4C693FFEFD9ABFFEAD2A8FFD4B284FFD0AE
          88FFE7D5CAFF885F53FF25181464000000070000000000000000755B53ACDFCE
          C9FFDDC1A8FFC99966FFE8C085FFE9C388FF8F4B24FFF1D8B1FFF3DDB8FFD6B3
          8AFFDBBEA6FFC5ACA2FF5A3D33C10000000C0000000000000000A9877CE9F8F4
          F2FFC79873FFDEAB77FFEFCDABFFF1D2B5FF8F4524FFEDC99EFFF1D4B2FFECCF
          AEFFC89B77FFE6D6CEFF7C5448F10000000F0000000000000000C09C90FFFDFD
          FCFFBE875FFFEDCFB9FF682612FF8A3F22FF8C4024FF8F4225FF924427FFF1CE
          AEFFC08B67FFF1E6DFFF8B6154FF0000000F0000000000000000AF9186E6F9F5
          F4FFC69474FFE8CDC3FFF9E8E4FFF6DED2FF8B3C23FFF1CEB6FFEBB78FFFE7BC
          9AFFC59172FFEBDFD9FF866055EE0000000D0000000000000000876F68B0E7D9
          D4FFE2C6B7FFC89072FFFAEFF2FFF9E7E4FF6A2213FFF1C8B2FFEBB08AFFCA8F
          6FFFDCBBAAFFD3C0B7FF6B4F46BC00000009000000000000000026201E36CCAF
          A7FAFBF8F7FFCF9F88FFC78E72FFE9CDC6FFEDC7B5FFDD9F79FFC88967FFCE9D
          84FFF5EFEBFFB39387FF2A201D52000000040000000000000000000000036454
          4F84D9C2BAFFFDFBFAFFE2C6B8FFCB977EFFC08163FFCB977DFFE0C4B4FFFAF6
          F5FFC9B0A7FF6B564EA700000009000000010000000000000000000000000202
          020762534D81CEB2A9FAEADDD8FFF9F5F4FFFFFFFFFFF9F5F4FFE9DCD7FFC8AC
          A2FC62504B900404031000000002000000000000000000000000000000000000
          000000000003241F1D3486726BADB69B91E6CCADA1FFB99C92E988736CB22822
          1F3E000000060000000100000000000000000000000000000000}
        ParentShowHint = False
        ShowHint = True
        OnClick = spbAmpliarClick
      end
      object lblGuia: TLabel
        Left = 44
        Top = 375
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Guia:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblCodRecTributo: TLabel
        Left = 203
        Top = 375
        Width = 115
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'd. Receita do Tributo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblContaFornecedor: TLabel
        Left = 38
        Top = 397
        Width = 31
        Height = 14
        Alignment = taRightJustify
        Caption = 'Conta:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblMensagem: TLabel
        Left = 160
        Top = 3
        Width = 218
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = '* Somente duplicatas com chave (NF-e)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblFanSob: TLabel
        Left = 12
        Top = 293
        Width = 57
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome Fant.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtGuia: TEdit
        Left = 71
        Top = 372
        Width = 122
        Height = 19
        AutoSize = False
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 14
      end
      object edtCodCliBai: TEdit
        Tag = 999
        Left = 71
        Top = 20
        Width = 307
        Height = 19
        AutoSize = False
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 0
      end
      object edtNomCliBai: TEdit
        Tag = 999
        Left = 71
        Top = 41
        Width = 307
        Height = 19
        AutoSize = False
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
      end
      object edtCodPorBai: TEdit
        Tag = 999
        Left = 71
        Top = 146
        Width = 307
        Height = 19
        AutoSize = False
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 6
      end
      object edtNomPorBai: TEdit
        Tag = 999
        Left = 71
        Top = 167
        Width = 307
        Height = 19
        AutoSize = False
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 7
      end
      object edtNosNum: TEdit
        Tag = 999
        Left = 71
        Top = 188
        Width = 307
        Height = 19
        AutoSize = False
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 8
      end
      object edtDesProtesta: TEdit
        Tag = 999
        Left = 71
        Top = 310
        Width = 307
        Height = 19
        AutoSize = False
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 11
      end
      object edtCodVel: TEdit
        Tag = 999
        Left = 71
        Top = 270
        Width = 307
        Height = 19
        AutoSize = False
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 10
      end
      object edtEndere: TEdit
        Tag = 999
        Left = 71
        Top = 62
        Width = 307
        Height = 19
        AutoSize = False
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 2
      end
      object edtBairro: TEdit
        Tag = 999
        Left = 71
        Top = 83
        Width = 307
        Height = 19
        AutoSize = False
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 3
      end
      object edtCidade: TEdit
        Tag = 999
        Left = 71
        Top = 104
        Width = 307
        Height = 19
        AutoSize = False
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 4
      end
      object edtCep: TEdit
        Tag = 999
        Left = 71
        Top = 125
        Width = 307
        Height = 19
        AutoSize = False
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 5
      end
      object edtLinDig: TEdit
        Tag = 999
        Left = 71
        Top = 351
        Width = 307
        Height = 19
        AutoSize = False
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 13
      end
      object edtCodBar: TEdit
        Tag = 999
        Left = 71
        Top = 330
        Width = 307
        Height = 19
        AutoSize = False
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 12
      end
      object edtHistor: TMemo
        Tag = 999
        Left = 71
        Top = 209
        Width = 307
        Height = 59
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 9
      end
      object edtCodRecTributo: TEdit
        Left = 320
        Top = 372
        Width = 58
        Height = 19
        AutoSize = False
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 15
      end
      object CBContaFornecedor: TComboBox
        Tag = 999
        Left = 71
        Top = 393
        Width = 307
        Height = 22
        TabOrder = 16
        OnChange = CBContaFornecedorChange
      end
      object pnlValoresDuplicata: TPanel
        Left = 2
        Top = 415
        Width = 400
        Height = 43
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 17
        Visible = False
        object Label13: TLabel
          Left = 4
          Top = 5
          Width = 63
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor Duplic.:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblValorDesconto: TLabel
          Left = 188
          Top = 5
          Width = 77
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor Desconto:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label16: TLabel
          Left = 10
          Top = 26
          Width = 57
          Height = 14
          Alignment = taRightJustify
          Caption = 'Outras Ent.:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtValorDuplicata: TEdit
          Left = 69
          Top = 2
          Width = 110
          Height = 19
          AutoSize = False
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
        end
        object edtValorDesconto: TEdit
          Left = 267
          Top = 2
          Width = 110
          Height = 19
          AutoSize = False
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
        end
        object edtOutrasEntidades: TEdit
          Left = 69
          Top = 23
          Width = 110
          Height = 19
          AutoSize = False
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
        end
      end
      object edtFanSob: TEdit
        Tag = 999
        Left = 71
        Top = 290
        Width = 307
        Height = 19
        AutoSize = False
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 18
      end
    end
    object pnlAux2: TPanel
      Left = 0
      Top = 22
      Width = 522
      Height = 462
      Align = alClient
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 0
      object Label11: TLabel
        Left = 0
        Top = 356
        Width = 522
        Height = 45
        Align = alBottom
        BiDiMode = bdLeftToRight
        Caption = 
          'SE FOR ALTERAR O TAMANHO DA TELA NA HORIZONTAL, TER'#193' QUE SER ALT' +
          'ERADO NA ROTINA DO BRADESCO240 - PAGAR TAMB'#201'M untGerDup (pGeraDu' +
          'pContasPagar) e untGerDupSel (FormShow)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
        Visible = False
        WordWrap = True
        ExplicitWidth = 489
      end
      object pnlTotais: TPanel
        Left = 0
        Top = 401
        Width = 522
        Height = 61
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label21: TLabel
          Left = 16
          Top = 14
          Width = 83
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
          Left = 8
          Top = 35
          Width = 91
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
        object edtTotalDup: TEditFocus
          Left = 109
          Top = 10
          Width = 121
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object edtTotalSelecionado: TEditFocus
          Left = 109
          Top = 30
          Width = 121
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object gpbLegenda: TGroupBox
          Left = 236
          Top = 2
          Width = 254
          Height = 53
          Caption = 'Legenda'
          TabOrder = 2
          object shp1: TShape
            Left = 8
            Top = 16
            Width = 14
            Height = 14
          end
          object lbl1: TLabel
            Left = 27
            Top = 16
            Width = 65
            Height = 14
            Caption = 'Selecionadas'
          end
          object shp2: TShape
            Left = 8
            Top = 32
            Width = 14
            Height = 14
          end
          object lbl2: TLabel
            Left = 27
            Top = 32
            Width = 98
            Height = 14
            Caption = 'Clientes com Cr'#233'dito'
          end
          object lbl3: TLabel
            Left = 11
            Top = 16
            Width = 8
            Height = 14
            Caption = 'A'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object lbl4: TLabel
            Left = 11
            Top = 32
            Width = 8
            Height = 14
            Caption = 'A'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object Shape1: TShape
            Left = 127
            Top = 16
            Width = 14
            Height = 14
          end
          object Label6: TLabel
            Left = 146
            Top = 16
            Width = 98
            Height = 14
            Caption = 'Duplicatas Baixadas'
          end
          object Label8: TLabel
            Left = 130
            Top = 16
            Width = 8
            Height = 14
            Caption = 'A'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
        end
      end
      object dbgDuplicatas: TcxGrid
        Left = 0
        Top = 0
        Width = 522
        Height = 356
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object dbgDuplicatasDBTableView1: TcxGridDBTableView
          OnDblClick = dbgDuplicatasDBTableView1DblClick
          OnKeyDown = dbgDuplicatasDBTableView1KeyDown
          OnKeyUp = dbgDuplicatasDBTableView1KeyUp
          Navigator.Buttons.CustomButtons = <>
          OnCellClick = dbgDuplicatasDBTableView1CellClick
          OnCustomDrawCell = dbgDuplicatasDBTableView1CustomDrawCell
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.ColumnHeaderHints = False
          OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
          OptionsView.GroupByBox = False
          object dbgDuplicatasDBTableView1CTR_NUMDUP: TcxGridDBColumn
            Caption = 'Duplicata'
            DataBinding.FieldName = 'CTR_NUMDUP'
            FooterAlignmentHorz = taCenter
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            HeaderGlyphAlignmentHorz = taCenter
            MinWidth = 80
            Options.Editing = False
            Width = 125
          end
          object dbgDuplicatasDBTableView1CTR_ESPDOC: TcxGridDBColumn
            Caption = 'Esp'#233'cie'
            DataBinding.FieldName = 'CTR_ESPDOC'
            MinWidth = 46
            Options.Editing = False
            Width = 50
          end
          object dbgDuplicatasDBTableView1FOR_NOMFOR: TcxGridDBColumn
            Caption = 'Fornecedor'
            Visible = False
            Options.Editing = False
            Width = 240
          end
          object dbgDuplicatasDBTableView1CTR_CODEMP: TcxGridDBColumn
            Caption = 'Empresa'
            DataBinding.FieldName = 'CTR_CODEMP'
            MinWidth = 48
            Options.Editing = False
            Width = 50
          end
          object dbgDuplicatasDBTableView1CTR_DTACAD: TcxGridDBColumn
            Caption = 'Emiss'#227'o'
            DataBinding.FieldName = 'CTR_DTACAD'
            MinWidth = 70
            Options.Editing = False
            Width = 72
          end
          object dbgDuplicatasDBTableView1CTR_DTAVEN: TcxGridDBColumn
            Caption = 'Vencimento'
            DataBinding.FieldName = 'CTR_DTAVEN'
            MinWidth = 65
            Options.Editing = False
            Width = 72
          end
          object dbgDuplicatasDBTableView1CTR_VALDUP: TcxGridDBColumn
            Caption = 'Valor'
            DataBinding.FieldName = 'CTR_VALDUP'
            FooterAlignmentHorz = taRightJustify
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            MinWidth = 80
            Options.Editing = False
            Width = 83
          end
          object dbgDuplicatasDBTableView1CTR_VALCOR: TcxGridDBColumn
            Caption = 'Valor Corrigido'
            DataBinding.FieldName = 'CTR_VALCOR'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            MinWidth = 80
            Options.Editing = False
            Width = 90
          end
          object dbgDuplicatasDBTableView1DEPOSI: TcxGridDBColumn
            Caption = 'Forma Pgto.'
            DataBinding.FieldName = 'DEPOSI'
            PropertiesClassName = 'TcxComboBoxProperties'
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              'Boleto'
              'Dep'#243'sito')
            Properties.OnChange = dbgDuplicatasDBTableView1DEPOSIPropertiesChange
            Visible = False
            MinWidth = 80
          end
          object dbgDuplicatasDBTableView1CODTED: TcxGridDBColumn
            Caption = 'Finalidade TED'
            DataBinding.FieldName = 'CODTED'
            PropertiesClassName = 'TcxComboBoxProperties'
            Properties.OnChange = dbgDuplicatasDBTableView1CODTEDPropertiesChange
            Visible = False
            MinWidth = 250
            Width = 250
          end
          object dbgDuplicatasDBTableView1MARCAD: TcxGridDBColumn
            DataBinding.FieldName = 'CTR_MARCAD'
            Visible = False
          end
          object dbgDuplicatasDBTableView1CREDIT: TcxGridDBColumn
            DataBinding.FieldName = 'CTR_CREDIT'
            Visible = False
          end
          object dbgDuplicatasDBTableView1DTAREC: TcxGridDBColumn
            DataBinding.FieldName = 'CTR_DTAREC'
            Visible = False
          end
          object dbgDuplicatasDBTableView1CTP_DEPOSI: TcxGridDBColumn
            DataBinding.FieldName = 'CTP_DEPOSI'
            Visible = False
          end
          object dbgDuplicatasDBTableView1CTR_OCORRE: TcxGridDBColumn
            Caption = 'Ocorr'#234'ncia'
            DataBinding.FieldName = 'CTR_OCORRE'
            PropertiesClassName = 'TcxComboBoxProperties'
            Properties.DropDownListStyle = lsFixedList
            Properties.OnValidate = dbgDuplicatasDBTableView1CTR_OCORREPropertiesValidate
            Visible = False
            MinWidth = 160
            Width = 180
          end
          object dbgDuplicatasDBTableView1PROTESTO: TcxGridDBColumn
            Caption = 'Protesto'
            DataBinding.FieldName = 'CLI_PROPER'
            PropertiesClassName = 'TcxComboBoxProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 47
          end
        end
        object dbgDuplicatasLevel1: TcxGridLevel
          GridView = dbgDuplicatasDBTableView1
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 200
    Top = 184
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 168
    Top = 184
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 104
    Top = 184
  end
  object dsContaFornecedor: TDataSource
    Left = 232
    Top = 186
  end
end
