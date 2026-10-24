inherited frmCadFasesOrdProd: TfrmCadFasesOrdProd
  Width = 621
  Height = 202
  Caption = 'Cadastro de fases'
  ExplicitWidth = 621
  ExplicitHeight = 202
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 129
    Width = 615
    ExplicitTop = 129
    ExplicitWidth = 615
    inherited FlwBotoes: TFlowPanel
      Width = 611
      ExplicitWidth = 611
      object btnSequencia: TBitBtnLocked
        Left = 432
        Top = 0
        Width = 89
        Height = 20
        Caption = '&Sequ'#234'ncia'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000070000
          000B0000000B0000000B0000000C0000000C0000000C0000000C0000000C0000
          000C0000000C0000000C0000000C0000000C00000008000000027F5447BEB074
          62FFAF7461FFAF7460FFAE735FFFAE725FFFAD715EFFAD715EFFAC705CFFAC70
          5CFFAC6F5BFFAC6F5BFFAB6F5BFFAB6E5AFF7B4F40BF00000008B67E6CFFFBF6
          F3FFFAF5F2FFFAF5F2FFFAF5F2FFFAF5F1FFFAF4F1FFFAF4F1FFF9F4F0FFF9F4
          F0FFF9F3F0FFF8F3EFFFF9F3EFFFF8F2EEFFB37968FF0000000BB77F6FFFFBF7
          F4FFF7EFE9FFF6EEE9FFF6EEE9FFF6EEE9FFF6EEE9FFF7EEE8FFF6EEE8FFF6EE
          E8FFF6EEE8FFF6EDE7FFF5EDE7FFF9F4F0FFB47B6AFF0000000BB88171FFFBF8
          F5FFF7F0EBFFA76D59FFA76D59FFA66D5AFFA66C58FFA66B58FFA56B57FFA46C
          58FFA46C56FFA46A56FFF6EEE9FFFAF4F2FFB47C6BFF0000000BB98472FFFCF9
          F7FFF8F0ECFFF8F1ECFFF7F0ECFFF7F0EBFFF8F0EBFFF7F0EBFFF7EFEAFFF7EF
          EAFFF7EFE9FFF7EFE9FFF6EFEAFFFAF6F3FFB67F6DFF0000000ABB8674FFFDFA
          F8FFF8F1EDFFF8F2EEFFF8F2EEFFF8F2EDFFF7F1EDFFF8F0ECFFF7F1EBFFF8F0
          EBFFF7F0EBFFF7EFEAFFF7F0EAFFFAF7F5FFB7806FFF00000009BB8674FFFDFA
          F8FFF8F1EDFFF9F3EFFFF9F2EFFFF8F2EEFFF8F2EDFFF8F1EDFFF8F1ECFFF8F1
          ECFFF8F0ECFFF7F0ECFFF7F0EAFFFAF7F5FFB7806FFF00000009BF8C7AFFFEFC
          FBFFFAF5F1FFAD7764FFAE7863FFAE7863FFAC7463FFAB7562FFAC7661FFAC76
          61FFAB7360FFAB7360FFF9F2EEFFFCFAF9FFBB8675FF00000008C08D7DFFFEFD
          FCFFFAF5F2FFFAF6F3FFFAF6F2FFFAF5F2FFFAF5F1FFF9F4F1FFF9F4F1FFF9F3
          F0FFF8F3EFFFF8F3EFFFF9F3F0FFFDFBFAFFBC8877FF00000008C28F7EFFFEFD
          FDFFFBF6F3FFFAF6F4FFFAF7F3FFFAF6F3FFFAF6F3FFFAF6F2FFF9F5F2FFF9F4
          F1FFF9F5F1FFF9F4F1FFFAF4F0FFFDFCFAFFBE8A79FF00000007C39281FFFEFE
          FDFFFBF7F4FFFBF7F4FFFAF7F5FFFBF7F4FFFAF6F4FFFAF6F4FFFAF5F3FFFAF6
          F2FFF9F5F2FFF9F5F2FFF9F6F2FFFDFCFCFFBF8D7BFF00000007C49483FFFFFE
          FEFFFBF8F5FFB5826FFFB5806DFFB4816EFFB4816CFFB3806DFFB37E6DFFB27D
          6CFFB27D6AFFB27D6AFFFAF6F3FFFEFDFCFFC08F7EFF00000006C59584FFFFFE
          FEFFFCF8F7FFFBF8F6FFFCF8F6FFFBF8F5FFFBF8F6FFFBF8F5FFFCF8F5FFFBF8
          F5FFFBF7F4FFFBF7F4FFFBF7F4FFFEFDFDFFC2907FFF00000005C69786FFFFFF
          FEFFFFFFFEFFFFFEFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFEFEFFFEFE
          FEFFFEFEFEFFFFFEFEFFFFFEFDFFFEFEFDFFC39281FF000000059A796DBFCFA4
          94FFCFA393FFCEA393FFCEA393FFCEA292FFCEA292FFCDA292FFCDA191FFCDA0
          90FFCCA090FFCC9F8FFFCB9E8EFFCB9E8EFF967569C000000003}
        TabOrder = 6
        OnClick = btnSequenciaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 534
      ExplicitLeft = 534
    end
  end
  inherited pnlStatus: TPanel
    Top = 157
    Width = 615
    ExplicitTop = 157
    ExplicitWidth = 615
    inherited pnlNomeForm: TPanel
      Left = 268
      ExplicitLeft = 268
    end
    inherited pnlInfo: TPanel
      Width = 268
      ExplicitWidth = 268
    end
  end
  inherited pgcDados: TPageControl
    Width = 615
    Height = 129
    ExplicitWidth = 615
    ExplicitHeight = 129
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 607
      ExplicitHeight = 97
      object Label1: TLabel
        Left = 26
        Top = 18
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
      end
      object Label2: TLabel
        Left = 11
        Top = 66
        Width = 52
        Height = 14
        Caption = 'Descri'#231#227'o:'
      end
      object lblSequencia: TLabel
        Left = 8
        Top = 42
        Width = 54
        Height = 14
        Alignment = taRightJustify
        Caption = 'Sequ'#234'ncia:'
      end
      object dbeCodigo: TDBEditFocus
        Tag = 99
        Left = 65
        Top = 14
        Width = 88
        Height = 22
        CharCase = ecUpperCase
        Color = 16768952
        DataField = 'FAS_CODIGO'
        DataSource = dtsTabela
        Enabled = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object dbeDescri: TDBEditFocus
        Tag = 99
        Left = 65
        Top = 62
        Width = 450
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FAS_DESFAS'
        DataSource = dtsTabela
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeSequencia: TDBEditFocus
        Tag = 99
        Left = 65
        Top = 38
        Width = 88
        Height = 22
        CharCase = ecUpperCase
        Color = 16768952
        DataField = 'FAS_SEQUEN'
        DataSource = dtsTabela
        Enabled = False
        ReadOnly = True
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 240
    Top = 0
  end
  object dtsTabela: TDataSource
    Left = 521
    Top = 49
  end
end
