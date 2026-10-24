inherited frmRelSimplesNacional: TfrmRelSimplesNacional
  Width = 1006
  Height = 630
  Caption = 'Resumo de Impostos Simples Nacional'
  Position = poMainFormCenter
  ExplicitWidth = 1006
  ExplicitHeight = 630
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 557
    Width = 1000
    ExplicitTop = 557
    ExplicitWidth = 1000
    inherited FlwBotoes: TFlowPanel
      Width = 996
      TabOrder = 1
      ExplicitWidth = 996
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 160
        Height = 22
        Caption = '[ F10 ] Calcular Apura'#231#227'o'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0002000000090000000E0000000F0000000F0000000F00000010000000100000
          00100000001100000011000000100000000B0000000300000000000000000000
          0008285B8FC0357DC6FF327AC4FF3077C2FF2D75C1FF2B73C0FF2870BEFF266E
          BDFF256DBCFF226BBBFF216AB9FF154B84C20000000A00000000000000000000
          000C3C82CAFF77C2EEFF64B7EAFF61B5EAFF5DB4E9FF5AB2E8FF58B0E7FF54AF
          E7FF51ACE7FF50ABE6FF4DAAE6FF216ABAFF0000000F00000000000000000000
          000C3F85CBFF80C7EFFF3F8BCBFF3C88CBFF3986C8FF3583C7FF3381C6FF307F
          C4FF2F7FC4FF2D7DC3FF50ACE7FF246CBBFF0000000F00000000000000000000
          000B4288CDFF88CBF0FF4490CEFFF3ECEAFFEDE6E4FFEFEAE7FFE6E1DEFFE9E4
          E1FFECE5E1FF3181C5FF55AFE7FF256EBDFF0000000F00000000000000000000
          000B458BD0FF91D0F1FF4A95D1FFF5F1EFFFEFECE9FFA8B7AFFF125838FF6688
          77FFE7E2DFFF4D91CDFF59B1E8FF2971BEFF0000000E00000000000000000000
          000A498ED2FF99D4F3FF65A5D8FFF5F3F2FFAEBFB5FF1E825BFF2EE1AAFF1574
          4FFFA2B0A7FF8BB5DAFF63B6E9FF2B73C0FF0000000D00000000000000000000
          00094C92D3FFADDDF5FFA3C8E6FFB6C9C0FF258863FF40ECB9FF38ECB7FF2BD1
          9CFF236749FF87ACC6FF95CCEDFF2F76C2FF0000000D00000000000000000000
          00094E95D5FFB8E1F7FF84B2BEFF34906CFF5EF2C9FF71F9D7FF77F7D7FF41EB
          B9FF23B081FF326D5FFFA7CDE3FF6499D1FF0000000C00000000000000000000
          00085397D7FFBEE4F7FF78AFB3FF4AAA89FF77DBBEFF419E7EFF237956FF6ADF
          C1FF41E9B8FF1D9A6FFF52867FFF92B4D6FF0000000D00000000000000000000
          0007559AD9FFC5E8F9FFAFD2ECFFA3C5B7FF52967BFF98B8A9FFC5D1CBFF408D
          6FFF6DE1C3FF48ECBDFF18855CFF5B8891FF0000001500000001000000000000
          0007589DDAFFBDE6F9FF84BCE4FFF8F8F8FFF0F0EEFFEEEEECFFEDEBEAFFD1D9
          D4FF3D896BFF62D0B3FF66EFCCFF1C6F4DFF0000001B00000002000000000000
          00065B9FDCFFC2E7F7FF6AA6D2FFA5A3A1FF7D7976FF645E5DFF696462FFABA8
          A8FFB2B7B3FF3B826DFF359170FF6D95A5FF0000001300000000000000000000
          00055DA1DEFFC5E6F5FF767C80FFB3AEACFFD2CDCAFFE5E0DDFFCFC6C1FFB8AF
          AAFFC1BEBDFFA6ABAFFFC3D9E6FF9BBDDEFF0000000A00000000000000000000
          00034778A6C05DA0DBFF918987FF8D8682FF88817FFFD0CCCAFFC8C3C1FF6C66
          64FF76726FFF837F7DFF5C95CBFF4E7BA6CA0000000500000000000000000000
          00010000000300000004000000050000000525232243716C6ACA605B59CA1D1B
          1B44000000060000000600000006000000040000000100000000}
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnLimparApuracao: TBitBtnLocked
        Left = 160
        Top = 0
        Width = 160
        Height = 22
        Caption = '[ F11 ] Limpar Apura'#231#227'o'
        Glyph.Data = {
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
        TabOrder = 1
        OnClick = btnLimparApuracaoClick
      end
      object btnImpAnexo: TBitBtnLocked
        Left = 320
        Top = 0
        Width = 155
        Height = 22
        Caption = 'Imprimir Anexo I'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF9F9D9EFF00FFFF00FFFF00FF8281818281818E8A
          8BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F9D9E9F9D9ED4D1D196
          93933B393A545253999797C5C2C4D7D5D5828181FF00FFFF00FFFF00FFFF00FF
          9F9D9E9F9D9EFAFAFAFFFFFFD7D4D59E9C9C4443451C1C1E1C1C1F3534356766
          678281818E8A8BFF00FF918E8F9F9D9EF0EEEFFFFFFFEEEBEBCAC9C99F9D9E8E
          8A8A9793958786866463633C3B3D1F2022201F21747273FF00FF9C9899E9E7E7
          E5E5E5BDBBBBA6A4A4B4B1B1C2C1C1A4A1A19692939290909793959A98988E8A
          8B6B6A6A828181FF00FF959192ADABACA4A1A1B0AFAFC9C9C9D1D3D3EDEDEBF0
          EEF0DCDADAC5C4C4ADABAB9A98999390909793958E8A8BFF00FF918E8FAFADAF
          C9C7C7CECECEC9C9C9E2E2E2D1CFCFA1ABA1BDBCBCCBCECFD5D5D5D3D3D3C6C5
          C5B6B6B6989797FF00FFFF00FF9C999AD0D1D1CFCFCFDCDCDCC9C6C6B5B0B4A5
          D1A7BAC4BCC5A7A1ADA4A3A9A6A7B4B1B2C2C1C1A9A6A7FF00FFFF00FFFF00FF
          9C999AC1BFBFAFADADB1B0B0E3E3E3F6F3F3EEEDEEEDE1DEDCD8D8CCCCCCB4B4
          B4939091FF00FFFF00FFFF00FFFF00FFFF00FF9C999AD8DADACACACB9D9FA0BB
          BFC1D3D5D7D4D9D9D5D5D5C6C5C6AFADADFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFBE5E1F8E0D4E9C9BDE3C7BDE2CCC7DED3CED0CECC959295FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDECEFFCFBDFF
          C4AFFFBAA3FFB199FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFCE9F9DFFDDCEFFCCBCFEC2B0FFBBA4F7A992FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDDCEFFCCBCFE
          C2B0FEB8A3FAB099FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFCE9F9DFAE0D5FFDACCFFCEBDFFC6B1FCB8A3F8AD99FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DCE9F9DCE9F9DCE9F9DF3
          AD9DF3AD9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 2
        OnClick = btnImpAnexoClick
      end
      object btnImprimir: TBitBtnLocked
        Left = 475
        Top = 0
        Width = 155
        Height = 22
        Caption = '&Imprimir'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF9F9D9EFF00FFFF00FFFF00FF8281818281818E8A
          8BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F9D9E9F9D9ED4D1D196
          93933B393A545253999797C5C2C4D7D5D5828181FF00FFFF00FFFF00FFFF00FF
          9F9D9E9F9D9EFAFAFAFFFFFFD7D4D59E9C9C4443451C1C1E1C1C1F3534356766
          678281818E8A8BFF00FF918E8F9F9D9EF0EEEFFFFFFFEEEBEBCAC9C99F9D9E8E
          8A8A9793958786866463633C3B3D1F2022201F21747273FF00FF9C9899E9E7E7
          E5E5E5BDBBBBA6A4A4B4B1B1C2C1C1A4A1A19692939290909793959A98988E8A
          8B6B6A6A828181FF00FF959192ADABACA4A1A1B0AFAFC9C9C9D1D3D3EDEDEBF0
          EEF0DCDADAC5C4C4ADABAB9A98999390909793958E8A8BFF00FF918E8FAFADAF
          C9C7C7CECECEC9C9C9E2E2E2D1CFCFA1ABA1BDBCBCCBCECFD5D5D5D3D3D3C6C5
          C5B6B6B6989797FF00FFFF00FF9C999AD0D1D1CFCFCFDCDCDCC9C6C6B5B0B4A5
          D1A7BAC4BCC5A7A1ADA4A3A9A6A7B4B1B2C2C1C1A9A6A7FF00FFFF00FFFF00FF
          9C999AC1BFBFAFADADB1B0B0E3E3E3F6F3F3EEEDEEEDE1DEDCD8D8CCCCCCB4B4
          B4939091FF00FFFF00FFFF00FFFF00FFFF00FF9C999AD8DADACACACB9D9FA0BB
          BFC1D3D5D7D4D9D9D5D5D5C6C5C6AFADADFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFBE5E1F8E0D4E9C9BDE3C7BDE2CCC7DED3CED0CECC959295FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDECEFFCFBDFF
          C4AFFFBAA3FFB199FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFCE9F9DFFDDCEFFCCBCFEC2B0FFBBA4F7A992FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDDCEFFCCBCFE
          C2B0FEB8A3FAB099FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFCE9F9DFAE0D5FFDACCFFCEBDFFC6B1FCB8A3F8AD99FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DCE9F9DCE9F9DCE9F9DF3
          AD9DF3AD9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 3
        OnClick = btnImprimirClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 917
      TabOrder = 0
      ExplicitLeft = 917
    end
  end
  inherited pnlStatus: TPanel
    Top = 585
    Width = 1000
    ExplicitTop = 585
    ExplicitWidth = 1000
    inherited pnlNomeForm: TPanel
      Left = 829
      ExplicitLeft = 829
    end
    inherited pnlInfo: TPanel
      Width = 829
      ExplicitWidth = 829
    end
  end
  object pgcApuracoes: TPageControl [2]
    Left = 0
    Top = 219
    Width = 1000
    Height = 338
    ActivePage = tshComercio
    Align = alClient
    TabOrder = 2
    StyleElements = [seFont, seBorder]
    OnChange = pgcApuracoesChange
    object tshComercio: TTabSheet
      Caption = '&1 - Com'#233'rcio (Anexo I)'
      object grdComercio: TcxGridCitel
        Left = 0
        Top = 55
        Width = 992
        Height = 254
        Align = alClient
        BorderStyle = cxcbsNone
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdComercioDados: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = grdComercioDadosCustomDrawCell
          DataController.DataSource = dtsComercio
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.KeyFieldNames = 'AUTOINCREM'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Nenhuma mensagem para ser exibida'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object grdComercio_IDXFXA: TcxGridDBColumn
            Caption = 'Nro'
            DataBinding.FieldName = 'TSN_IDXFXA'
            SortIndex = 0
            SortOrder = soAscending
            Width = 40
          end
          object grdComercio_LIMINF: TcxGridDBColumn
            Caption = 'Lim. Inferior (R$)'
            DataBinding.FieldName = 'TSN_LIMINF'
            Width = 110
          end
          object grdComercio_LIMSUP: TcxGridDBColumn
            Caption = 'Lim. Superior (R$)'
            DataBinding.FieldName = 'TSN_LIMSUP'
            Width = 110
          end
          object grdComercio_VLRDES: TcxGridDBColumn
            Caption = 'Vr. Descontar (R$)'
            DataBinding.FieldName = 'TSN_VLRDES'
            Width = 110
          end
          object grdComercio_ALIQUO: TcxGridDBColumn
            Caption = '% Al'#237'quota'
            DataBinding.FieldName = 'TSN_ALIQUO'
            Width = 60
          end
          object grdComercio_ALIRPJ: TcxGridDBColumn
            Caption = '% IRPJ'
            DataBinding.FieldName = 'TSN_ALIRPJ'
            Width = 55
          end
          object grdComercio_ALCSLL: TcxGridDBColumn
            Caption = '% CSLL'
            DataBinding.FieldName = 'TSN_ALCSLL'
            Width = 55
          end
          object grdComercio_ALQCOF: TcxGridDBColumn
            Caption = '% COFINS'
            DataBinding.FieldName = 'TSN_ALQCOF'
            Width = 60
          end
          object grdComercio_ALQPIS: TcxGridDBColumn
            Caption = '% PIS'
            DataBinding.FieldName = 'TSN_ALQPIS'
            Width = 55
          end
          object grdComercio_ALQCPP: TcxGridDBColumn
            Caption = '% CPP'
            DataBinding.FieldName = 'TSN_ALQCPP'
            Width = 55
          end
          object grdComercio_ALQICM: TcxGridDBColumn
            Caption = '% ICMS'
            DataBinding.FieldName = 'TSN_ALQICM'
            Width = 55
          end
          object grdComercio_ALQIBS: TcxGridDBColumn
            Caption = '% IBS'
            DataBinding.FieldName = 'TSN_ALQIBS'
            Width = 55
          end
          object grdComercio_ALQCBS: TcxGridDBColumn
            Caption = '% CBS'
            DataBinding.FieldName = 'TSN_ALQCBS'
            Width = 55
          end
          object grdComercio_ALQTRB: TcxGridDBColumn
            Caption = '% Trib.'
            DataBinding.FieldName = 'TSN_ALQTRB'
          end
          object grdComercio_TOTTRB: TcxGridDBColumn
            Caption = 'Valor Imp. Trib.'
            DataBinding.FieldName = 'TSN_TOTTRB'
            Width = 80
          end
          object grdComercio_ALQRET: TcxGridDBColumn
            Caption = '% ST'
            DataBinding.FieldName = 'TSN_ALQRET'
          end
          object grdComercio_TOTRET: TcxGridDBColumn
            Caption = 'Valor Imp. ST'
            DataBinding.FieldName = 'TSN_TOTRET'
            Width = 80
          end
          object grdComercio_TOTSNC: TcxGridDBColumn
            Caption = 'Total a Recolher'
            DataBinding.FieldName = 'TSN_TOTSNC'
            Width = 120
          end
        end
        object grdComercioLvl1: TcxGridLevel
          GridView = grdComercioDados
        end
      end
      object pnlComercio: TPanel
        Left = 0
        Top = 0
        Width = 992
        Height = 55
        Align = alTop
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        StyleElements = [seFont, seBorder]
        object lblFatTribComercio: TLabel
          Left = 14
          Top = 6
          Width = 163
          Height = 14
          Caption = 'Faturamento Produtos Tributados:'
        end
        object lblFatRetComercio: TLabel
          Left = 14
          Top = 30
          Width = 179
          Height = 14
          Caption = 'Faturamento Produtos Sub.Tribut'#225'ria:'
        end
        object lblFatIsentoComercio: TLabel
          Left = 374
          Top = 6
          Width = 223
          Height = 14
          Caption = 'Faturamento Produtos Isentos/N'#227'o Tributados:'
        end
        object lblAliqEfetiva1: TLabel
          Left = 760
          Top = 5
          Width = 222
          Height = 14
          Caption = '* Configurado para usar Al'#237'quotra Efetiva'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object edtFatProdTribComercio: TEditFocus
          Tag = 99
          Left = 195
          Top = 3
          Width = 153
          Height = 22
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 0
          OnExit = edtValFatMesesExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtFatProdRetComercio: TEditFocus
          Tag = 99
          Left = 195
          Top = 27
          Width = 153
          Height = 22
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 1
          OnExit = edtValFatMesesExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtFatProdIsentoComercio: TEditFocus
          Tag = 99
          Left = 601
          Top = 3
          Width = 153
          Height = 22
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 2
          OnExit = edtValFatMesesExit
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
    end
    object tshIndustria: TTabSheet
      Caption = '&2 - Ind'#250'stria (Anexo II)'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object grdIndustria: TcxGridCitel
        Left = 0
        Top = 55
        Width = 992
        Height = 254
        Align = alClient
        BorderStyle = cxcbsNone
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdIndustriaDados: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = grdIndustriaDadosCustomDrawCell
          DataController.DataSource = dtsIndustria
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.KeyFieldNames = 'AUTOINCREM'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Nenhuma mensagem para ser exibida'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object grdIndustria_IDXFXA: TcxGridDBColumn
            Caption = 'Nro'
            DataBinding.FieldName = 'TSN_IDXFXA'
            SortIndex = 0
            SortOrder = soAscending
            Width = 40
          end
          object grdIndustria_LIMINF: TcxGridDBColumn
            Caption = 'Lim. Inferior (R$)'
            DataBinding.FieldName = 'TSN_LIMINF'
            Width = 110
          end
          object grdIndustria_LIMSUP: TcxGridDBColumn
            Caption = 'Lim. Superior (R$)'
            DataBinding.FieldName = 'TSN_LIMSUP'
            Width = 110
          end
          object grdIndustria_VLRDES: TcxGridDBColumn
            Caption = 'Vr. Descontar (R$)'
            DataBinding.FieldName = 'TSN_VLRDES'
            Width = 110
          end
          object grdIndustria_ALIQUO: TcxGridDBColumn
            Caption = '% Al'#237'quota'
            DataBinding.FieldName = 'TSN_ALIQUO'
            Width = 60
          end
          object grdIndustria_ALIRPJ: TcxGridDBColumn
            Caption = '% IRPJ'
            DataBinding.FieldName = 'TSN_ALIRPJ'
            Width = 55
          end
          object grdIndustria_ALCSLL: TcxGridDBColumn
            Caption = '% CSLL'
            DataBinding.FieldName = 'TSN_ALCSLL'
            Width = 55
          end
          object grdIndustria_ALQCOF: TcxGridDBColumn
            Caption = '% COFINS'
            DataBinding.FieldName = 'TSN_ALQCOF'
            Width = 60
          end
          object grdIndustria_ALQPIS: TcxGridDBColumn
            Caption = '% PIS'
            DataBinding.FieldName = 'TSN_ALQPIS'
            Width = 55
          end
          object grdIndustria_ALQCPP: TcxGridDBColumn
            Caption = '% CPP'
            DataBinding.FieldName = 'TSN_ALQCPP'
            Width = 55
          end
          object grdIndustria_ALQICM: TcxGridDBColumn
            Caption = '% ICMS'
            DataBinding.FieldName = 'TSN_ALQICM'
            Width = 55
          end
          object grdIndustria_ALQIBS: TcxGridDBColumn
            Caption = '% IBS'
            DataBinding.FieldName = 'TSN_ALQIBS'
            Width = 55
          end
          object grdIndustria_ALQCBS: TcxGridDBColumn
            Caption = '% CBS'
            DataBinding.FieldName = 'TSN_ALQCBS'
            Width = 55
          end
          object grdIndustria_ALQIPI: TcxGridDBColumn
            Caption = '% IPI'
            DataBinding.FieldName = 'TSN_ALQIPI'
            Width = 55
          end
          object grdIndustria_ALQTRB: TcxGridDBColumn
            Caption = '% Trib.'
            DataBinding.FieldName = 'TSN_ALQTRB'
          end
          object grdIndustria_TOTTRB: TcxGridDBColumn
            Caption = 'Valor Imp. Trib.'
            DataBinding.FieldName = 'TSN_TOTTRB'
          end
          object grdIndustria_ALQRET: TcxGridDBColumn
            Caption = '% ST'
            DataBinding.FieldName = 'TSN_ALQRET'
          end
          object grdIndustria_TOTRET: TcxGridDBColumn
            Caption = 'Valor Imp. ST'
            DataBinding.FieldName = 'TSN_TOTRET'
          end
          object grdIndustria_TOTSNC: TcxGridDBColumn
            Caption = 'Total a Recolher'
            DataBinding.FieldName = 'TSN_TOTSNC'
          end
        end
        object grdIndustriaLvl1: TcxGridLevel
          GridView = grdIndustriaDados
        end
      end
      object pnlIndustria: TPanel
        Left = 0
        Top = 0
        Width = 992
        Height = 55
        Align = alTop
        Color = clWhite
        ParentBackground = False
        TabOrder = 1
        StyleElements = [seFont, seBorder]
        object lblFatTribIndustria: TLabel
          Left = 14
          Top = 6
          Width = 163
          Height = 14
          Caption = 'Faturamento Produtos Tributados:'
        end
        object lblFatRetIndustria: TLabel
          Left = 14
          Top = 30
          Width = 179
          Height = 14
          Caption = 'Faturamento Produtos Sub.Tribut'#225'ria:'
        end
        object lblFatIsentoIndustria: TLabel
          Left = 374
          Top = 6
          Width = 223
          Height = 14
          Caption = 'Faturamento Produtos Isentos/N'#227'o Tributados:'
        end
        object lblAliqEfetiva2: TLabel
          Left = 760
          Top = 5
          Width = 222
          Height = 14
          Caption = '* Configurado para usar Al'#237'quotra Efetiva'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object edtFatProdTribIndustria: TEditFocus
          Tag = 99
          Left = 195
          Top = 3
          Width = 153
          Height = 22
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 0
          OnExit = edtValFatMesesExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtFatProdRetIndustria: TEditFocus
          Tag = 99
          Left = 195
          Top = 27
          Width = 153
          Height = 22
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 1
          OnExit = edtValFatMesesExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtFatProdIsentoIndustria: TEditFocus
          Tag = 99
          Left = 601
          Top = 1
          Width = 153
          Height = 22
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 2
          OnExit = edtValFatMesesExit
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
    end
    object tshServicosIII: TTabSheet
      Caption = '&3 - Servi'#231'os (Anexo III)'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlServicosIII: TPanel
        Left = 0
        Top = 0
        Width = 992
        Height = 30
        Align = alTop
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        StyleElements = [seFont, seBorder]
        object lblFatServServicosIIIIss: TLabel
          Left = 14
          Top = 5
          Width = 109
          Height = 14
          Caption = 'Faturamento Servi'#231'os:'
        end
        object lblFatServServicosIIIIssRet: TLabel
          Left = 300
          Top = 8
          Width = 181
          Height = 14
          Caption = 'Faturamento Servi'#231'os com Reten'#231#227'o:'
        end
        object lblAliqEfetiva3: TLabel
          Left = 760
          Top = 5
          Width = 222
          Height = 14
          Caption = '* Configurado para usar Al'#237'quotra Efetiva'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object edtFatServServicosIIIIss: TEditFocus
          Tag = 99
          Left = 129
          Top = 2
          Width = 153
          Height = 22
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 0
          OnExit = edtValFatMesesExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtFatServServicosIIIIssRet: TEditFocus
          Tag = 99
          Left = 487
          Top = 2
          Width = 153
          Height = 22
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 1
          OnExit = edtValFatMesesExit
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
      object grdServicosIII: TcxGridCitel
        Left = 0
        Top = 30
        Width = 992
        Height = 279
        Align = alClient
        BorderStyle = cxcbsNone
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdServicosIIIDados: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = grdServicosIIIDadosCustomDrawCell
          DataController.DataSource = dtsServicosIII
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.KeyFieldNames = 'AUTOINCREM'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Nenhuma mensagem para ser exibida'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object grdServicosIII_IDXFXA: TcxGridDBColumn
            Caption = 'Nro'
            DataBinding.FieldName = 'TSN_IDXFXA'
            SortIndex = 0
            SortOrder = soAscending
            Width = 40
          end
          object grdServicosIII_LIMINF: TcxGridDBColumn
            Caption = 'Lim. Inferior (R$)'
            DataBinding.FieldName = 'TSN_LIMINF'
            Width = 110
          end
          object grdServicosIII_LIMSUP: TcxGridDBColumn
            Caption = 'Lim. Superior (R$)'
            DataBinding.FieldName = 'TSN_LIMSUP'
            Width = 110
          end
          object grdServicosIII_VLRDES: TcxGridDBColumn
            Caption = 'Vr. Descontar (R$)'
            DataBinding.FieldName = 'TSN_VLRDES'
            Width = 110
          end
          object grdServicosIII_ALIQUO: TcxGridDBColumn
            Caption = '% Al'#237'quota'
            DataBinding.FieldName = 'TSN_ALIQUO'
            Width = 60
          end
          object grdServicosIII_ALIRPJ: TcxGridDBColumn
            Caption = '% IRPJ'
            DataBinding.FieldName = 'TSN_ALIRPJ'
            Width = 55
          end
          object grdServicosIII_ALCSLL: TcxGridDBColumn
            Caption = '% CSLL'
            DataBinding.FieldName = 'TSN_ALCSLL'
            Width = 55
          end
          object grdServicosIII_ALQCOF: TcxGridDBColumn
            Caption = '% COFINS'
            DataBinding.FieldName = 'TSN_ALQCOF'
            Width = 60
          end
          object grdServicosIII_ALQPIS: TcxGridDBColumn
            Caption = '% PIS'
            DataBinding.FieldName = 'TSN_ALQPIS'
            Width = 55
          end
          object grdServicosIII_ALQCPP: TcxGridDBColumn
            Caption = '% CPP'
            DataBinding.FieldName = 'TSN_ALQCPP'
            Width = 55
          end
          object grdServicosIII_ALQICM: TcxGridDBColumn
            Caption = '% ICMS'
            DataBinding.FieldName = 'TSN_ALQICM'
            Width = 55
          end
          object grdServicosIII_ALQIBS: TcxGridDBColumn
            Caption = '% IBS'
            DataBinding.FieldName = 'TSN_ALQIBS'
            Width = 55
          end
          object grdServicosIII_ALQCBS: TcxGridDBColumn
            Caption = '% CBS'
            DataBinding.FieldName = 'TSN_ALQCBS'
            Width = 55
          end
          object grdServicosIII_ALQISS: TcxGridDBColumn
            Caption = '% ISS'
            DataBinding.FieldName = 'TSN_ALQISS'
            Width = 55
          end
          object grdServicosIII_TOTSNC: TcxGridDBColumn
            Caption = 'Total a Recolher'
            DataBinding.FieldName = 'TSN_TOTSNC'
          end
        end
        object grdServicosIIILvl1: TcxGridLevel
          GridView = grdServicosIIIDados
        end
      end
    end
    object tshServicosIV: TTabSheet
      Caption = '&4 - Servi'#231'os (Anexo IV)'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlServicosIV: TPanel
        Left = 0
        Top = 0
        Width = 992
        Height = 30
        Align = alTop
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        StyleElements = [seFont, seBorder]
        object lblFatServServicosIVIss: TLabel
          Left = 14
          Top = 6
          Width = 109
          Height = 14
          Caption = 'Faturamento Servi'#231'os:'
        end
        object lblFatServServicosIVIssRet: TLabel
          Left = 300
          Top = 8
          Width = 181
          Height = 14
          Caption = 'Faturamento Servi'#231'os com Reten'#231#227'o:'
        end
        object lblAliqEfetiva4: TLabel
          Left = 759
          Top = 5
          Width = 222
          Height = 14
          Caption = '* Configurado para usar Al'#237'quotra Efetiva'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object edtFatServServicosIVIss: TEditFocus
          Tag = 99
          Left = 126
          Top = 3
          Width = 153
          Height = 22
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 0
          OnExit = edtValFatMesesExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtFatServServicosIVIssRet: TEditFocus
          Tag = 99
          Left = 487
          Top = 3
          Width = 153
          Height = 22
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 1
          OnExit = edtValFatMesesExit
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
      object grdServicosIV: TcxGridCitel
        Left = 0
        Top = 30
        Width = 992
        Height = 279
        Align = alClient
        BorderStyle = cxcbsNone
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdServicosIVDados: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = grdServicosIVDadosCustomDrawCell
          DataController.DataSource = dtsServicosIV
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.KeyFieldNames = 'AUTOINCREM'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Nenhuma mensagem para ser exibida'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object grdServicosIV_IDVFXA: TcxGridDBColumn
            Caption = 'Nro'
            DataBinding.FieldName = 'TSN_IDXFXA'
            SortIndex = 0
            SortOrder = soAscending
            Width = 40
          end
          object grdServicosIV_LIMINF: TcxGridDBColumn
            Caption = 'Lim. Inferior (R$)'
            DataBinding.FieldName = 'TSN_LIMINF'
            Width = 110
          end
          object grdServicosIV_LIMSUP: TcxGridDBColumn
            Caption = 'Lim. Superior (R$)'
            DataBinding.FieldName = 'TSN_LIMSUP'
            Width = 110
          end
          object grdServicosIV_VLRDES: TcxGridDBColumn
            Caption = 'Vr. Descontar (R$)'
            DataBinding.FieldName = 'TSN_VLRDES'
            Width = 110
          end
          object grdServicosIV_ALIQUO: TcxGridDBColumn
            Caption = '% Al'#237'quota'
            DataBinding.FieldName = 'TSN_ALIQUO'
            Width = 60
          end
          object grdServicosIV_ALIRPJ: TcxGridDBColumn
            Caption = '% IRPJ'
            DataBinding.FieldName = 'TSN_ALIRPJ'
            Width = 55
          end
          object grdServicosIV_ALCSLL: TcxGridDBColumn
            Caption = '% CSLL'
            DataBinding.FieldName = 'TSN_ALCSLL'
            Width = 55
          end
          object grdServicosIV_ALQCOF: TcxGridDBColumn
            Caption = '% COFINS'
            DataBinding.FieldName = 'TSN_ALQCOF'
            Width = 60
          end
          object grdServicosIV_ALQPIS: TcxGridDBColumn
            Caption = '% PIS'
            DataBinding.FieldName = 'TSN_ALQPIS'
            Width = 55
          end
          object grdServicosIV_ALQCPP: TcxGridDBColumn
            Caption = '% CPP'
            DataBinding.FieldName = 'TSN_ALQCPP'
            Width = 55
          end
          object grdServicosIV_ALQICM: TcxGridDBColumn
            Caption = '% ICMS'
            DataBinding.FieldName = 'TSN_ALQICM'
            Width = 55
          end
          object grdServicosIV_ALQIBS: TcxGridDBColumn
            Caption = '% IBS'
            DataBinding.FieldName = 'TSN_ALQIBS'
            Width = 55
          end
          object grdServicosIV_ALQCBS: TcxGridDBColumn
            Caption = '% CBS'
            DataBinding.FieldName = 'TSN_ALQCBS'
            Width = 55
          end
          object grdServicosIV_ALQISS: TcxGridDBColumn
            Caption = '% ISS'
            DataBinding.FieldName = 'TSN_ALQISS'
            Width = 55
          end
          object grdServicosIV_TOTSNC: TcxGridDBColumn
            Caption = 'Total a Recolher'
            DataBinding.FieldName = 'TSN_TOTSNC'
          end
        end
        object grdServicosIVLvl1: TcxGridLevel
          GridView = grdServicosIVDados
        end
      end
    end
    object tshServicosVA: TTabSheet
      Caption = '&5 - Servi'#231'os (Anexo V-A)'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object grdServicosVA: TcxGridCitel
        Left = 0
        Top = 30
        Width = 992
        Height = 279
        Align = alClient
        BorderStyle = cxcbsNone
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdServicosVADados: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = grdServicosVADadosCustomDrawCell
          DataController.DataSource = dtsServicosVA
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.KeyFieldNames = 'AUTOINCREM'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Nenhuma mensagem para ser exibida'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object grdServicosVA_IDXFXA: TcxGridDBColumn
            Caption = 'Nro'
            DataBinding.FieldName = 'TSN_IDXFXA'
            SortIndex = 0
            SortOrder = soAscending
            Width = 40
          end
          object grdServicosVA_LIMINF: TcxGridDBColumn
            Caption = 'Lim. Inferior (R$)'
            DataBinding.FieldName = 'TSN_LIMINF'
            Width = 110
          end
          object grdServicosVA_LIMSUP: TcxGridDBColumn
            Caption = 'Lim. Superior (R$)'
            DataBinding.FieldName = 'TSN_LIMSUP'
            Width = 110
          end
          object grdServicosVA_VLRDES: TcxGridDBColumn
            Caption = 'Vr. Descontar (R$)'
            DataBinding.FieldName = 'TSN_VLRDES'
            Width = 110
          end
          object grdServicosVA_ALIQUO: TcxGridDBColumn
            Caption = '% Al'#237'quota'
            DataBinding.FieldName = 'TSN_ALIQUO'
            Width = 60
          end
          object grdServicosVA_ALIRPJ: TcxGridDBColumn
            Caption = '% IRPJ'
            DataBinding.FieldName = 'TSN_ALIRPJ'
            Width = 55
          end
          object grdServicosVA_ALCSLL: TcxGridDBColumn
            Caption = '% CSLL'
            DataBinding.FieldName = 'TSN_ALCSLL'
            Width = 55
          end
          object grdServicosVA_ALQCOF: TcxGridDBColumn
            Caption = '% COFINS'
            DataBinding.FieldName = 'TSN_ALQCOF'
            Width = 60
          end
          object grdServicosVA_ALQPIS: TcxGridDBColumn
            Caption = '% PIS'
            DataBinding.FieldName = 'TSN_ALQPIS'
            Width = 55
          end
          object grdServicosVA_ALQCPP: TcxGridDBColumn
            Caption = '% CPP'
            DataBinding.FieldName = 'TSN_ALQCPP'
            Width = 55
          end
          object grdServicosVA_ALQICM: TcxGridDBColumn
            Caption = '% ICMS'
            DataBinding.FieldName = 'TSN_ALQICM'
            Width = 55
          end
          object grdServicosVA_ALQIBS: TcxGridDBColumn
            Caption = '% IBS'
            DataBinding.FieldName = 'TSN_ALQIBS'
            Width = 55
          end
          object grdServicosVA_ALQCBS: TcxGridDBColumn
            Caption = '% CBS'
            DataBinding.FieldName = 'TSN_ALQCBS'
            Width = 55
          end
          object grdServicosVA_ALQISS: TcxGridDBColumn
            Caption = '% ISS'
            DataBinding.FieldName = 'TSN_ALQISS'
            Width = 55
          end
          object grdServicosVA_TOTSNC: TcxGridDBColumn
            Caption = 'Total a Recolher'
            DataBinding.FieldName = 'TSN_TOTSNC'
          end
        end
        object grdServicosVALvl1: TcxGridLevel
          GridView = grdServicosVADados
        end
      end
      object pnlServicosVA: TPanel
        Left = 0
        Top = 0
        Width = 992
        Height = 30
        Align = alTop
        Color = clWhite
        ParentBackground = False
        TabOrder = 1
        StyleElements = [seFont, seBorder]
        object lblFatServServicosVAIss: TLabel
          Left = 14
          Top = 6
          Width = 109
          Height = 14
          Caption = 'Faturamento Servi'#231'os:'
        end
        object lblFatServServicosVAIssRet: TLabel
          Left = 300
          Top = 8
          Width = 181
          Height = 14
          Caption = 'Faturamento Servi'#231'os com Reten'#231#227'o:'
        end
        object lblAliqEfetiva5: TLabel
          Left = 759
          Top = 5
          Width = 222
          Height = 14
          Caption = '* Configurado para usar Al'#237'quotra Efetiva'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object edtFatServServicosVAIss: TEditFocus
          Tag = 99
          Left = 126
          Top = 3
          Width = 153
          Height = 22
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 0
          OnExit = edtValFatMesesExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtFatServServicosVAIssRet: TEditFocus
          Tag = 99
          Left = 487
          Top = 3
          Width = 153
          Height = 22
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 1
          OnExit = edtValFatMesesExit
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
    end
    object tshIndustriaSimples: TTabSheet
      Caption = '6 - Industria Simp. Nacional(Anexo V-I)'
      ImageIndex = 6
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 992
        Height = 33
        Align = alTop
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        StyleElements = [seFont, seBorder]
        object Label3: TLabel
          Left = 14
          Top = 6
          Width = 163
          Height = 14
          Caption = 'Faturamento Produtos Tributados:'
        end
        object Label4: TLabel
          Left = 370
          Top = 6
          Width = 179
          Height = 14
          Caption = 'Faturamento Produtos Sub.Tribut'#225'ria:'
        end
        object lblAliqEfetiva6: TLabel
          Left = 759
          Top = 5
          Width = 222
          Height = 14
          Caption = '* Configurado para usar Al'#237'quotra Efetiva'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object edtFatProdTribIndustriaSimples: TEditFocus
          Tag = 99
          Left = 195
          Top = 3
          Width = 153
          Height = 22
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 0
          OnExit = edtValFatMesesExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtFatProdRetIndustriaSimples: TEditFocus
          Tag = 99
          Left = 551
          Top = 3
          Width = 153
          Height = 22
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 1
          OnExit = edtValFatMesesExit
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
      object grdIndustriaSimples: TcxGridCitel
        Left = 0
        Top = 33
        Width = 992
        Height = 276
        Align = alClient
        BorderStyle = cxcbsNone
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdIndustriaSimplesDados: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = grdIndustriaDadosCustomDrawCell
          DataController.DataSource = dtsIndustriaSimples
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.KeyFieldNames = 'AUTOINCREM'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Nenhuma mensagem para ser exibida'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxGridDBColumn1: TcxGridDBColumn
            Caption = 'Nro'
            DataBinding.FieldName = 'TSN_IDXFXA'
            SortIndex = 0
            SortOrder = soAscending
            Width = 40
          end
          object cxGridDBColumn2: TcxGridDBColumn
            Caption = 'Lim. Inferior (R$)'
            DataBinding.FieldName = 'TSN_LIMINF'
            Width = 110
          end
          object cxGridDBColumn3: TcxGridDBColumn
            Caption = 'Lim. Superior (R$)'
            DataBinding.FieldName = 'TSN_LIMSUP'
            Width = 110
          end
          object cxGridDBColumn4: TcxGridDBColumn
            Caption = 'Vr. Descontar (R$)'
            DataBinding.FieldName = 'TSN_VLRDES'
            Width = 110
          end
          object cxGridDBColumn5: TcxGridDBColumn
            Caption = '% Al'#237'quota'
            DataBinding.FieldName = 'TSN_ALIQUO'
            Width = 60
          end
          object cxGridDBColumn6: TcxGridDBColumn
            Caption = '% IRPJ'
            DataBinding.FieldName = 'TSN_ALIRPJ'
            Width = 55
          end
          object cxGridDBColumn7: TcxGridDBColumn
            Caption = '% CSLL'
            DataBinding.FieldName = 'TSN_ALCSLL'
            Width = 55
          end
          object cxGridDBColumn8: TcxGridDBColumn
            Caption = '% COFINS'
            DataBinding.FieldName = 'TSN_ALQCOF'
            Width = 60
          end
          object cxGridDBColumn9: TcxGridDBColumn
            Caption = '% PIS'
            DataBinding.FieldName = 'TSN_ALQPIS'
            Width = 55
          end
          object cxGridDBColumn10: TcxGridDBColumn
            Caption = '% CPP'
            DataBinding.FieldName = 'TSN_ALQCPP'
            Width = 55
          end
          object cxGridDBColumn11: TcxGridDBColumn
            Caption = '% ICMS'
            DataBinding.FieldName = 'TSN_ALQICM'
            Width = 55
          end
          object grdIndustriaSimples_ALQIBS: TcxGridDBColumn
            Caption = '% IBS'
            DataBinding.FieldName = 'TSN_ALQIBS'
            Width = 55
          end
          object grdIndustriaSimples_ALQCBS: TcxGridDBColumn
            Caption = '% CBS'
            DataBinding.FieldName = 'TSN_ALQCBS'
            Width = 55
          end
          object cxGridDBColumn12: TcxGridDBColumn
            Caption = '% IPI'
            DataBinding.FieldName = 'TSN_ALQIPI'
            Width = 55
          end
          object cxGridDBColumn13: TcxGridDBColumn
            Caption = '% Trib.'
            DataBinding.FieldName = 'TSN_ALQTRB'
          end
          object grdIndustriaSimp_ALQCBS: TcxGridDBColumn
            Caption = '% CBS'
            DataBinding.FieldName = 'TSN_ALQCBS'
          end
          object grdIndustriaSimp_ALQIBS: TcxGridDBColumn
            Caption = '% IBS'
            DataBinding.FieldName = 'TSN_ALQIBS'
          end
          object cxGridDBColumn14: TcxGridDBColumn
            Caption = 'Valor Imp. Trib.'
            DataBinding.FieldName = 'TSN_TOTTRB'
          end
          object cxGridDBColumn15: TcxGridDBColumn
            Caption = '% ST'
            DataBinding.FieldName = 'TSN_ALQRET'
          end
          object cxGridDBColumn16: TcxGridDBColumn
            Caption = 'Valor Imp. ST'
            DataBinding.FieldName = 'TSN_TOTRET'
          end
          object cxGridDBColumn17: TcxGridDBColumn
            Caption = 'Total a Recolher'
            DataBinding.FieldName = 'TSN_TOTSNC'
          end
        end
        object grdIndustriaSimplesLvl1: TcxGridLevel
          GridView = grdIndustriaSimplesDados
        end
      end
    end
    object tshResumo: TTabSheet
      Caption = 'Resumo da Apura'#231#227'o'
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Resumo: TPanel
        Left = 0
        Top = 0
        Width = 992
        Height = 30
        Align = alTop
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        StyleElements = [seFont, seBorder]
        object lblTotalRecolher: TLabel
          Left = 14
          Top = 6
          Width = 80
          Height = 14
          Caption = 'Total a Recolher:'
        end
        object edtTotalRecolher: TEditFocus
          Tag = 99
          Left = 102
          Top = 3
          Width = 153
          Height = 22
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 0
          OnExit = edtValFatMesesExit
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
      object grdResumo: TcxGridCitel
        Left = 0
        Top = 30
        Width = 992
        Height = 279
        Align = alClient
        BorderStyle = cxcbsNone
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdResumoDados: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = grdResumoDadosCustomDrawCell
          DataController.DataSource = dtsResumo
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.KeyFieldNames = 'AUTOINCREM'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Nenhuma mensagem para ser exibida'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object grdResumo_TABELA: TcxGridDBColumn
            Caption = 'Tabela'
            DataBinding.FieldName = 'TSN_TABELA'
            SortIndex = 0
            SortOrder = soAscending
            Width = 100
          end
          object grdResumo_LIMINF: TcxGridDBColumn
            Caption = 'Lim. Inferior (R$)'
            DataBinding.FieldName = 'TSN_LIMINF'
            Width = 110
          end
          object grdResumo_LIMSUP: TcxGridDBColumn
            Caption = 'Lim. Superior (R$)'
            DataBinding.FieldName = 'TSN_LIMSUP'
            Width = 110
          end
          object grdResumo_VLRDES: TcxGridDBColumn
            Caption = 'Vr. Descontar (R$)'
            DataBinding.FieldName = 'TSN_VLRDES'
            Width = 110
          end
          object grdResumo_TOTTRB: TcxGridDBColumn
            Caption = 'Base Calc. Trib.'
            DataBinding.FieldName = 'TSN_TOTTRB'
          end
          object grdResumo_TOTRET: TcxGridDBColumn
            Caption = 'Base Calc. ST'
            DataBinding.FieldName = 'TSN_TOTRET'
          end
          object grdResumo_TOTISE: TcxGridDBColumn
            Caption = 'Base Calc. Isento'
            DataBinding.FieldName = 'TSN_TOTISE'
          end
          object grdResumo_TOTISS: TcxGridDBColumn
            Caption = 'Base Calc. ISS'
            DataBinding.FieldName = 'TSN_TOTISS'
          end
          object grdResumo_TOTISR: TcxGridDBColumn
            Caption = 'Base Calc. ISS Retido'
            DataBinding.FieldName = 'TSN_TOTISR'
          end
          object grdResumo_ALIQUO: TcxGridDBColumn
            Caption = '% Al'#237'quota'
            DataBinding.FieldName = 'TSN_ALIQUO'
            Width = 60
          end
          object grdResumo_ALIRPJ: TcxGridDBColumn
            Caption = '% IRPJ'
            DataBinding.FieldName = 'TSN_ALIRPJ'
            Width = 55
          end
          object grdResumo_ALCSLL: TcxGridDBColumn
            Caption = '% CSLL'
            DataBinding.FieldName = 'TSN_ALCSLL'
            Width = 55
          end
          object grdResumo_ALQCOF: TcxGridDBColumn
            Caption = '% COFINS'
            DataBinding.FieldName = 'TSN_ALQCOF'
            Width = 60
          end
          object grdResumo_ALQPIS: TcxGridDBColumn
            Caption = '% PIS'
            DataBinding.FieldName = 'TSN_ALQPIS'
            Width = 55
          end
          object grdResumo_ALQCPP: TcxGridDBColumn
            Caption = '% CPP'
            DataBinding.FieldName = 'TSN_ALQCPP'
            Width = 55
          end
          object grdResumo_ALQICM: TcxGridDBColumn
            Caption = '% ICMS'
            DataBinding.FieldName = 'TSN_ALQICM'
            Width = 55
          end
          object grdResumo_ALQIBS: TcxGridDBColumn
            Caption = '% IBS'
            DataBinding.FieldName = 'TSN_ALQIBS'
            Width = 55
          end
          object grdResumo_ALQCBS: TcxGridDBColumn
            Caption = '% CBS'
            DataBinding.FieldName = 'TSN_ALQCBS'
            Width = 55
          end
          object grdResumo_ALQISS: TcxGridDBColumn
            Caption = '% ISS'
            DataBinding.FieldName = 'TSN_ALQISS'
            Width = 55
          end
          object grdResumo_ALQIPI: TcxGridDBColumn
            Caption = '% IPI'
            DataBinding.FieldName = 'TSN_ALQIPI'
          end
          object grdResumo_TOTSNC: TcxGridDBColumn
            Caption = 'Total a Recolher'
            DataBinding.FieldName = 'TSN_TOTSNC'
          end
        end
        object grdResumoLvl1: TcxGridLevel
          GridView = grdResumoDados
        end
      end
    end
  end
  object grpDadosApuracao: TGroupBox [3]
    Left = 0
    Top = 0
    Width = 1000
    Height = 219
    Align = alTop
    Caption = '   Dados para Apura'#231#227'o   '
    TabOrder = 3
    object Panel1: TPanel
      Left = 2
      Top = 184
      Width = 996
      Height = 33
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      object Label2: TLabel
        Left = 99
        Top = 8
        Width = 135
        Height = 14
        Caption = 'Receita Bruta em 12 meses:'
      end
      object edtReceitaBruta: TEditFocus
        Tag = 99
        Left = 240
        Top = 0
        Width = 153
        Height = 22
        Alignment = taRightJustify
        ReadOnly = True
        TabOrder = 0
        OnExit = edtValFatMesesExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object chkCalculoManual: TCheckBox
        Left = 397
        Top = 5
        Width = 97
        Height = 17
        Hint = 
          'Marque esta op'#231#227'o para informar manualmente os valores de fatura' +
          'mento do m'#234's de apura'#231#227'o e meses anteriores'
        Caption = 'C'#225'lculo manual'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = chkCalculoManualClick
      end
    end
    object Panel2: TPanel
      Left = 2
      Top = 118
      Width = 996
      Height = 66
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object lblMesAtual: TLabel
        Left = 146
        Top = 8
        Width = 88
        Height = 14
        Caption = 'M'#234's de Apura'#231#227'o:'
      end
      object lblFatMesAtual: TLabel
        Left = 67
        Top = 32
        Width = 167
        Height = 14
        Caption = 'Vr. Faturamento m'#234's de apura'#231#227'o:'
      end
      object lblSep2: TLabel
        Left = 2
        Top = 49
        Width = 996
        Height = 14
        Caption = 
          '________________________________________________________________' +
          '________________________________________________________________' +
          '______________________________________'
        Enabled = False
      end
      object mskMesAtual: TMaskEditFocus
        Tag = 99
        Left = 240
        Top = 5
        Width = 50
        Height = 22
        EditMask = '99/9999;1;_'
        MaxLength = 7
        TabOrder = 0
        Text = '  /    '
        OnEnter = mskMesAtualEnter
        OnExit = mskMesAtualExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtFatMesAtual: TEditFocus
        Tag = 99
        Left = 240
        Top = 29
        Width = 153
        Height = 22
        Alignment = taRightJustify
        ReadOnly = True
        TabOrder = 2
        OnExit = edtValFatMesesExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object btnCalcMesAtual: TBitBtnLocked
        Left = 397
        Top = 29
        Width = 120
        Height = 22
        Caption = '[ F6 ] Calcular'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000100000005040F0B2F104531A51A68
          49EB1B7350FF196849EB104530A6030F0A310000000600000001000000000000
          000000000000000000000000000000000005082117531D7352F5299F75FF31BD
          8DFF54D9B0FF2EBD8BFF279D73FF1B7050F50820175600000006000000000000
          000000000000000000000000000204100C2C237958F536BF90FF3FD2A2FF5ADC
          B4FF135C3BFF57DBB1FF3AD09DFF30BC8CFF217655F5040F0B2F000000000000
          0000000000000000000000000004164C389F3AAE86FF41D5A5FF3AC597FF1560
          3FFF15603FFF155F3EFF40C599FF38D09DFF31A980FF154A35A1000000000000
          000000000001000000030000000925785AE746CEA3FF47D8AAFF45D6A8FF53DB
          B0FF63DFB9FF176442FF2FA67CFF3DD2A1FF3BC898FF227355E7000000000000
          0003060C16281D39669F1B3560972D8968FD55DBB3FF4DDAAEFF4FDBAFFF44AA
          87FF196B47FF2C966EFF45D7A8FF43D6A6FF48D6A8FF298262FA000000020E1B
          304C3462A7F45091CDFF5B859EB0368F71F66BDBBAFF52DDB3FF4ACFA4FF1C70
          4DFF68DCB9FF6CE3C1FF52DBB1FF49D8AAFF60D7B2FF287C5EE7070E1726396A
          ADF46AB5E3FF8BCEF0FF315387C5236365D863C0A3FF66E3BFFF55DFB6FF1E75
          51FF1E7550FF1E7550FF42C097FF5DDFB9FF5CBC9EFF1C533F9A25426D9A67A6
          D9FF80D0F2FF5E8DC5FF315F9DE040788DAE399677FA7FDAC1FF7CE9CCFF64E3
          BFFF207954FF62E2BDFF77E7C8FF79D8BDFF338D6DF106110D253D6AABE586CD
          EFFFBBEAFAFF2E58A8FF98CAE9FF8AB3C5CB42838BBB3A9A79FB64C1A4FF86DF
          C7FF97EFD9FF84DFC6FF62C0A2FF379272F40F29204B000000024779BEF99CE0
          F7FF1B48A3FF1A47A2FF1A46A2FF18439AF661A1BFCB478093AD3E8D83D93B97
          7BF43A9C79FF348A6BE3235D489D07120E2200000002000000004573B4E5A9DE
          F4FF9BE1F9FF3060B3FF96CCECFF8DD7F5FFA3DEF7FF78B9D5E05B9BB9C55B88
          A2B028456D9200000004000000020000000100000000000000002F4D77958EBB
          E4FFADEAFAFF5F9AD4FF5286C9FFB0DDF4FF4E82C6FF6BB1E2FF8BD4F3FF7BAF
          DFFF2C4A729600000002000000000000000000000000000000000A1019205184
          C5F0B2DBF2FFB7E9F9FF528ACEFF255AB7FF4D85CBFFA3DDF6FF9FD0EEFF4D7E
          C0F1090F18220000000000000000000000000000000000000000000000011826
          39475488CAF38EBCE6FFB7DFF4FFCAF1FCFFB0DCF4FF87B7E3FF5284C6F31725
          3848000000010000000000000000000000000000000000000000000000000000
          00010B11192035557E974F7FBCE15990D5FF4F7EBBE23556809B0A1119200000
          0001000000000000000000000000000000000000000000000000}
        TabOrder = 3
        OnClick = btnCalcMesAtualClick
      end
      object chkCFOPBoni: TCheckBox
        Left = 397
        Top = 6
        Width = 268
        Height = 17
        Hint = 
          'Desmarque esta op'#231#227'o para desconsiderar os CFOP'#39's de bonifica'#231#227'o' +
          ' dos resultados do relat'#243'rio'
        Caption = 'Considerar CFOP'#39's de bonifica'#231#227'o (5910/6910)'
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 1
      end
    end
    object Panel3: TPanel
      Left = 2
      Top = 16
      Width = 996
      Height = 102
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object lblFatMeses: TLabel
        Left = 16
        Top = 12
        Width = 218
        Height = 14
        Caption = 'Vr. Faturamento dos           meses anteriores:'
      end
      object lblSep1: TLabel
        Left = 0
        Top = 88
        Width = 996
        Height = 14
        Align = alBottom
        Caption = 
          '________________________________________________________________' +
          '________________________________________________________________' +
          '______________________________________'
        Enabled = False
      end
      object lblPeriodoApurado: TLabel
        Left = 528
        Top = 12
        Width = 82
        Height = 14
        Caption = 'Per'#237'odo apurado:'
        Visible = False
      end
      object edtMeses: TEditFocus
        Tag = 99
        Left = 120
        Top = 9
        Width = 20
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 2
        TabOrder = 0
        OnExit = edtMesesExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 2
        TipoTexto = ttNumerico
      end
      object edtValFatMeses: TEditFocus
        Tag = 99
        Left = 240
        Top = 9
        Width = 153
        Height = 22
        Alignment = taRightJustify
        TabOrder = 1
        OnExit = edtValFatMesesExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object btnCalcMeses: TBitBtnLocked
        Left = 397
        Top = 9
        Width = 120
        Height = 22
        Caption = '[ F5 ] Calcular'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000100000005040F0B2F104531A51A68
          49EB1B7350FF196849EB104530A6030F0A310000000600000001000000000000
          000000000000000000000000000000000005082117531D7352F5299F75FF31BD
          8DFF54D9B0FF2EBD8BFF279D73FF1B7050F50820175600000006000000000000
          000000000000000000000000000204100C2C237958F536BF90FF3FD2A2FF5ADC
          B4FF135C3BFF57DBB1FF3AD09DFF30BC8CFF217655F5040F0B2F000000000000
          0000000000000000000000000004164C389F3AAE86FF41D5A5FF3AC597FF1560
          3FFF15603FFF155F3EFF40C599FF38D09DFF31A980FF154A35A1000000000000
          000000000001000000030000000925785AE746CEA3FF47D8AAFF45D6A8FF53DB
          B0FF63DFB9FF176442FF2FA67CFF3DD2A1FF3BC898FF227355E7000000000000
          0003060C16281D39669F1B3560972D8968FD55DBB3FF4DDAAEFF4FDBAFFF44AA
          87FF196B47FF2C966EFF45D7A8FF43D6A6FF48D6A8FF298262FA000000020E1B
          304C3462A7F45091CDFF5B859EB0368F71F66BDBBAFF52DDB3FF4ACFA4FF1C70
          4DFF68DCB9FF6CE3C1FF52DBB1FF49D8AAFF60D7B2FF287C5EE7070E1726396A
          ADF46AB5E3FF8BCEF0FF315387C5236365D863C0A3FF66E3BFFF55DFB6FF1E75
          51FF1E7550FF1E7550FF42C097FF5DDFB9FF5CBC9EFF1C533F9A25426D9A67A6
          D9FF80D0F2FF5E8DC5FF315F9DE040788DAE399677FA7FDAC1FF7CE9CCFF64E3
          BFFF207954FF62E2BDFF77E7C8FF79D8BDFF338D6DF106110D253D6AABE586CD
          EFFFBBEAFAFF2E58A8FF98CAE9FF8AB3C5CB42838BBB3A9A79FB64C1A4FF86DF
          C7FF97EFD9FF84DFC6FF62C0A2FF379272F40F29204B000000024779BEF99CE0
          F7FF1B48A3FF1A47A2FF1A46A2FF18439AF661A1BFCB478093AD3E8D83D93B97
          7BF43A9C79FF348A6BE3235D489D07120E2200000002000000004573B4E5A9DE
          F4FF9BE1F9FF3060B3FF96CCECFF8DD7F5FFA3DEF7FF78B9D5E05B9BB9C55B88
          A2B028456D9200000004000000020000000100000000000000002F4D77958EBB
          E4FFADEAFAFF5F9AD4FF5286C9FFB0DDF4FF4E82C6FF6BB1E2FF8BD4F3FF7BAF
          DFFF2C4A729600000002000000000000000000000000000000000A1019205184
          C5F0B2DBF2FFB7E9F9FF528ACEFF255AB7FF4D85CBFFA3DDF6FF9FD0EEFF4D7E
          C0F1090F18220000000000000000000000000000000000000000000000011826
          39475488CAF38EBCE6FFB7DFF4FFCAF1FCFFB0DCF4FF87B7E3FF5284C6F31725
          3848000000010000000000000000000000000000000000000000000000000000
          00010B11192035557E974F7FBCE15990D5FF4F7EBBE23556809B0A1119200000
          0001000000000000000000000000000000000000000000000000}
        TabOrder = 2
        OnClick = btnCalcMesesClick
      end
      object pnlEmpresasRaiz: TPanel
        Left = 0
        Top = 37
        Width = 996
        Height = 51
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 3
        object Label1: TLabel
          Left = 17
          Top = 4
          Width = 167
          Height = 28
          Caption = 'Empresas da mesma ra'#237'z de CNPJ optante pelo simples nacional:'
          WordWrap = True
        end
        object btnVisualizarEmpresas: TBitBtnLocked
          Left = 528
          Top = 5
          Width = 213
          Height = 22
          Caption = 'Visualizar Faturamento por Empresa'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000100000005040F0B2F104531A51A68
            49EB1B7350FF196849EB104530A6030F0A310000000600000001000000000000
            000000000000000000000000000000000005082117531D7352F5299F75FF31BD
            8DFF54D9B0FF2EBD8BFF279D73FF1B7050F50820175600000006000000000000
            000000000000000000000000000204100C2C237958F536BF90FF3FD2A2FF5ADC
            B4FF135C3BFF57DBB1FF3AD09DFF30BC8CFF217655F5040F0B2F000000000000
            0000000000000000000000000004164C389F3AAE86FF41D5A5FF3AC597FF1560
            3FFF15603FFF155F3EFF40C599FF38D09DFF31A980FF154A35A1000000000000
            000000000001000000030000000925785AE746CEA3FF47D8AAFF45D6A8FF53DB
            B0FF63DFB9FF176442FF2FA67CFF3DD2A1FF3BC898FF227355E7000000000000
            0003060C16281D39669F1B3560972D8968FD55DBB3FF4DDAAEFF4FDBAFFF44AA
            87FF196B47FF2C966EFF45D7A8FF43D6A6FF48D6A8FF298262FA000000020E1B
            304C3462A7F45091CDFF5B859EB0368F71F66BDBBAFF52DDB3FF4ACFA4FF1C70
            4DFF68DCB9FF6CE3C1FF52DBB1FF49D8AAFF60D7B2FF287C5EE7070E1726396A
            ADF46AB5E3FF8BCEF0FF315387C5236365D863C0A3FF66E3BFFF55DFB6FF1E75
            51FF1E7550FF1E7550FF42C097FF5DDFB9FF5CBC9EFF1C533F9A25426D9A67A6
            D9FF80D0F2FF5E8DC5FF315F9DE040788DAE399677FA7FDAC1FF7CE9CCFF64E3
            BFFF207954FF62E2BDFF77E7C8FF79D8BDFF338D6DF106110D253D6AABE586CD
            EFFFBBEAFAFF2E58A8FF98CAE9FF8AB3C5CB42838BBB3A9A79FB64C1A4FF86DF
            C7FF97EFD9FF84DFC6FF62C0A2FF379272F40F29204B000000024779BEF99CE0
            F7FF1B48A3FF1A47A2FF1A46A2FF18439AF661A1BFCB478093AD3E8D83D93B97
            7BF43A9C79FF348A6BE3235D489D07120E2200000002000000004573B4E5A9DE
            F4FF9BE1F9FF3060B3FF96CCECFF8DD7F5FFA3DEF7FF78B9D5E05B9BB9C55B88
            A2B028456D9200000004000000020000000100000000000000002F4D77958EBB
            E4FFADEAFAFF5F9AD4FF5286C9FFB0DDF4FF4E82C6FF6BB1E2FF8BD4F3FF7BAF
            DFFF2C4A729600000002000000000000000000000000000000000A1019205184
            C5F0B2DBF2FFB7E9F9FF528ACEFF255AB7FF4D85CBFFA3DDF6FF9FD0EEFF4D7E
            C0F1090F18220000000000000000000000000000000000000000000000011826
            39475488CAF38EBCE6FFB7DFF4FFCAF1FCFFB0DCF4FF87B7E3FF5284C6F31725
            3848000000010000000000000000000000000000000000000000000000000000
            00010B11192035557E974F7FBCE15990D5FF4F7EBBE23556809B0A1119200000
            0001000000000000000000000000000000000000000000000000}
          TabOrder = 0
          OnClick = btnVisualizarEmpresasClick
        end
        object chklEmpresas: TCheckListBox
          Left = 190
          Top = 0
          Width = 327
          Height = 51
          ItemHeight = 14
          TabOrder = 1
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1016
    Top = 544
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 1016
    Top = 640
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 1016
    Top = 592
  end
  object dtsComercio: TDataSource
    Left = 252
    Top = 323
  end
  object dtsIndustria: TDataSource
    Left = 252
    Top = 371
  end
  object dtsServicosIII: TDataSource
    Left = 252
    Top = 419
  end
  object dtsServicosIV: TDataSource
    Left = 332
    Top = 323
  end
  object dtsServicosVA: TDataSource
    Left = 332
    Top = 371
  end
  object dtsResumo: TDataSource
    Left = 332
    Top = 419
  end
  object cdsAgruEmp: TUniClientDataSet
    PersistDataPacket.Data = {
      5C0000009619E0BD0100000018000000030000000000030000005C0006434F44
      454D50010049000000010005574944544802000200030004434E504A01004900
      000001000557494454480200020014000556414C4F5208000400000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODEMP'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'CNPJ'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'VALOR'
        DataType = ftFloat
      end>
    IndexDefs = <
      item
        Name = 'DEFAULT_ORDER'
      end
      item
        Name = 'CHANGEINDEX'
      end>
    IndexFieldNames = 'CODEMP'
    Params = <>
    StoreDefs = True
    Left = 480
    Top = 380
    object cdsAgruEmpCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsAgruEmpCNPJ: TStringField
      FieldName = 'CNPJ'
    end
    object cdsAgruEmpVALOR: TFloatField
      FieldName = 'VALOR'
    end
  end
  object dtsIndustriaSimples: TDataSource
    Left = 252
    Top = 475
  end
end
