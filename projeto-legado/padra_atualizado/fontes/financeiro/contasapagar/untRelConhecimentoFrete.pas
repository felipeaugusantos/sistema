unit untRelConhecimentoFrete;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, frxDBSet,Uni,untFuncoesSimples,
  frxExportPDF,dxCustomPreview;

type
  TfrmRelConhecimentoFrete = class(TForm)
    frxRelatorioConFre: TfrxReport;
    frxDadosConnhecimentoFrete: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
  private
    { Private declarations }
    function GetSQLConhecimentoFrete:String;
  public
    { Public declarations }
    procedure VisualizarRelConhecimentoFrete(ANumDoc:String; ASerie_: String;
                                             ACodEmp:String; ACodFor:String);
  end;

var
  frmRelConhecimentoFrete: TfrmRelConhecimentoFrete;

implementation

{$R *.dfm}

{ TfrmRelConhecimentoFrete }

function TfrmRelConhecimentoFrete.GetSQLConhecimentoFrete: String;
begin

  Result := 'SELECT                                                     '+
            '  NUMDOC,                                                  '+
            '  SERIEF,                                                  '+
            '  DTAENT,                                                  '+
            '  NOMFOR,                                                  '+
            '  CLFSC1,                                                  '+
            '  VLCON1,                                                  '+
            '  DOCENT,                                                  '+
            '  SERIEE,                                                  '+
            '  DTADOC,                                                  '+
            '  FORENT,                                                  '+
            '  CLFSEN,                                                  '+
            '  VLRENT,                                                  '+
            '  FIS_NUMDOC,                                              '+
            '  FIS_SERIE_,                                              '+
            '  FIS_CODEMP,                                              '+
            '  FIS_FORCLI,                                              '+
            '  (SELECT                                                  '+
            '    GROUP_CONCAT(                                          '+
            '      CONCAT(                                              '+
            '        CTP_NUMDUP,                                        '+
            '        "-",                                               '+
            '        CTP_PARCEL,                                        '+
            '        "-",                                               '+
            '        CTP_CODEMP,                                        '+
            '        "       ",                                         '+
            '        CTP_SERIE_,                                        '+
            '        "                ",                                '+
            '        DATE_FORMAT(CTP_DTAVEN,"%d/%m/%Y"),                '+
            '        "                     ",                           '+
            '        FORMAT(CTP_VALORI, 2, "de_DE")                     '+
            '      )                                                    '+
            '    )                                                      '+
            '  FROM                                                     '+
            '    CADPAG                                                 '+
            '  WHERE CTP_NUMDUP = FIS_NUMDOC                            '+
            '    AND CTP_CODEMP = FIS_CODEMP                            '+
            '    AND IFNULL(CTP_SERIE_, "") = FIS_SERIE_                '+
            '    AND CTP_CODFOR = FIS_FORCLI) AS DUPLICATAS,            '+
            '  "" AS ESP,                                               '+
            '  "" AS ESP1                                               '+
            'FROM                                                       '+
            '  (SELECT                                                  '+
            '    CONCAT(                                                '+
            '      A.FIS_NUMDOC,                                        '+
            '      "-",                                                 '+
            '      A.FIS_ESPDOC,                                        '+
            '      "-",                                                 '+
            '      A.FIS_CODEMP                                         '+
            '    ) AS NUMDOC,                                           '+
            '    A.FIS_SERIE_ AS SERIEF,                                '+
            '    A.FIS_DTAENT AS DTAENT,                                '+
            '    CONCAT(A.FIS_FORCLI, "-", B.FOR_NOMFOR) AS NOMFOR,     '+
            '    A.FIS_CLFSC1 AS CLFSC1,                                '+
            '    A.FIS_VLCON1 AS VLCON1,                                '+
            '    CONCAT(                                                '+
            '      E.FIS_NUMDOC,                                        '+
            '      "-",                                                 '+
            '      E.FIS_ESPDOC,                                        '+
            '      "-",                                                 '+
            '      E.FIS_CODEMP                                         '+
            '    ) AS DOCENT,                                           '+
            '    E.FIS_SERIE_ AS SERIEE,                                '+
            '    E.FIS_DTADOC AS DTADOC,                                '+
            '    CONCAT(E.FIS_FORCLI, "-", F.FOR_NOMFOR) AS FORENT,     '+
            '    E.FIS_CLFSC1 AS CLFSEN,                                '+
             '   IFNULL(E.FIS_VLCON1, 0) + IFNULL(E.FIS_VLCON2, 0) + IFNULL(E.FIS_VLCON3, 0) + IFNULL(E.FIS_VLCON4, 0) + IFNULL(E.FIS_VLCON5, 0) AS VLRENT, '+
            '    A.FIS_NUMDOC,                                          '+
            '    A.FIS_SERIE_,                                          '+
            '    A.FIS_CODEMP,                                          '+
            '    A.FIS_FORCLI                                           '+
            '  FROM                                                     '+
            '    CONFRE                                                 '+
            '    INNER JOIN CADFIS A                                    '+
            '      ON A.AUTOINCREM = CON_SEQFIS                         '+
            '    INNER JOIN CADFOR B                                    '+
            '      ON B.FOR_CODFOR = A.FIS_FORCLI                       '+
            '    LEFT JOIN MOVGER                                       '+
            '      ON MOVGER.AUTOINCREM = CON_SEQGER                    '+
            '    LEFT JOIN CADFIS E                                     '+
            '      ON E.FIS_NUMDOC = GER_NUMDOC                         '+
            '      AND E.FIS_ESPDOC = GER_ESPDOC                        '+
            '      AND E.FIS_CODEMP = GER_CODEMP                        '+
            '      AND E.FIS_FORCLI = GER_CODFOR                        '+
            '      AND IFNULL(E.FIS_SERIE_, "") = IFNULL(GER_SERIE_, "")   '+
            '    LEFT JOIN CADFOR F                                     '+
            '      ON F.FOR_CODFOR = E.FIS_FORCLI                       '+
            '  WHERE A.FIS_TIP_FC = "F"                                 '+
            '    AND A.FIS_NUMDOC = :NUMDOC                             '+
            '    AND A.FIS_CODEMP = :CODEMP                             '+
            '    AND A.FIS_SERIE_ = :SERIE_                             '+
            '    AND A.FIS_FORCLI = :CODFOR                             '+
            '  UNION                                                    '+
            '  ALL                                                      '+
            '  SELECT                                                   '+
            '    CONCAT(                                                '+
            '      A.FIS_NUMDOC,                                        '+
            '      "-",                                                 '+
            '      A.FIS_ESPDOC,                                        '+
            '      "-",                                                 '+
            '      A.FIS_CODEMP                                         '+
            '    ) AS NUMDOC,                                           '+
            '    A.FIS_SERIE_ AS SERIEF,                                '+
            '    A.FIS_DTAENT AS DTAENT,                                '+
            '    CONCAT(A.FIS_FORCLI, "-", B.FOR_NOMFOR) AS NOMFOR,     '+
            '    A.FIS_CLFSC1 AS CLFSC1,                                '+
            '    A.FIS_VLCON1 AS VLCON1,                                '+
            '    CONCAT(                                                '+
            '      E.FIS_NUMDOC,                                        '+
            '      "-",                                                 '+
            '      E.FIS_ESPDOC,                                        '+
            '      "-",                                                 '+
            '      E.FIS_CODEMP                                         '+
            '    ) AS DOCENT,                                           '+
            '    E.FIS_SERIE_ AS SERIEE,                                '+
            '    E.FIS_DTADOC AS DTADOC,                                '+
            '    CONCAT(E.FIS_FORCLI, "-", F.FOR_NOMFOR) AS FORENT,     '+
            '    E.FIS_CLFSC1 AS CLFSEN,                                '+
            '    IFNULL(E.FIS_VLCON1, 0) + IFNULL(E.FIS_VLCON2, 0) + IFNULL(E.FIS_VLCON3, 0) + IFNULL(E.FIS_VLCON4, 0) + IFNULL(E.FIS_VLCON5, 0) AS VLRENT, '+
            '    A.FIS_NUMDOC,                                          '+
            '    A.FIS_SERIE_,                                          '+
            '    A.FIS_CODEMP,                                          '+
            '    A.FIS_FORCLI                                           '+
            '  FROM                                                     '+
            '    CADFIS A                                               '+
            '    LEFT JOIN CONFRE                                       '+
            '      ON A.AUTOINCREM = CON_SEQFIS                         '+
            '    LEFT JOIN CADFIS E                                     '+
            '      ON FALSE                                             '+
            '    INNER JOIN CADFOR B                                    '+
            '      ON B.FOR_CODFOR = A.FIS_FORCLI                       '+
            '    LEFT JOIN CADFOR F                                     '+
            '      ON FALSE                                             '+
            '  WHERE CON_SEQFIS IS NULL                                 '+
            '    AND A.FIS_ESPDOC IN ("CT", "CO")                       '+
            '    AND A.FIS_TIP_FC = "F"                                 '+
            '    AND A.FIS_NUMDOC = :NUMDOC                             '+
            '    AND A.FIS_CODEMP = :CODEMP                             '+
            '    AND A.FIS_SERIE_ = :SERIE_                             '+
            '    AND A.FIS_FORCLI = :CODFOR) AS FF                      '+
            'ORDER BY DTAENT,                                           '+
            '  NUMDOC                                                   ';
end;

procedure TfrmRelConhecimentoFrete.VisualizarRelConhecimentoFrete(ANumDoc,ASerie_,
                                                                  ACodEmp,ACodFor: String);
  Var
    LConFre : TUniQuery;
begin
  LConFre := fCriaQuery(Nil);
  Try

    Try
      LConFre.Close;
      LConFre.SQL.Add(GetSQLConhecimentoFrete);
      LConFre.ParamByName('NUMDOC').AsString := ANumDoc;
      LConFre.ParamByName('SERIE_').AsString := ASerie_;
      LConFre.ParamByName('CODEMP').AsString := ACodEmp;
      LConFre.ParamByName('CODFOR').AsString := ACodFor;
      LConFre.Open;

      If LConFre.IsEmpty Then
      Begin
        fMensagem('AVISO', 'Não há dados para gerar o relatório!', ['&O k']);
        Exit;
      End;

      frxRelatorioConFre.Script.Variables['NOME_EMPRESA'] := fRetNomeEmpresa(VS_strCodEmp);
      frxDadosConnhecimentoFrete.DataSet := LConFre;

      If frxRelatorioConFre.PrepareReport Then
        frxRelatorioConFre.ShowReport;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[VisualizarRelConhecimentoFrete]');
      End;
    End;

  Finally
    FreeAndNil(LConFre);
  End;
end;

end.
