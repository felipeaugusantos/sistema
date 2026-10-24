{*******************************}
{* EFETUA A GRAVAÇÃO DO LOGMCA *}
{* A PARTIR DE UM CARTÃO       *}
{****************************AJ*}
unit untLogMca;

interface

uses
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE }
  untFuncoesSimples, Vcl.Forms, untVersaoProg, Uni,
  {$ENDIF LINUX}
  System.SysUtils, System.DateUtils, System.Variants;

  {$IFDEF LINUX}
  procedure pGravaLogMca(AAutoincrem: String;
                         ADescricao: String;
                         AFormulario: String);
  {$ELSE }
  procedure GravaLogMca(AAutoIncrem: String;
                        ADescricao,
                        ANomeFormulario: String;
                        AAutoIncremLog: String = '');
  {$ENDIF LINUX}


implementation

{$IFDEF LINUX}
procedure pGravaLogMca(AAutoincrem: String;
                       ADescricao: String;
                       AFormulario: String);
var
  LQryMovCar: IQuery;
  LQryLogMca: IQuery;
  I: Integer;
Begin
  LQryMovCar := fCriarQuery('SELECT * FROM MOVCAR WHERE AUTOINCREM = "' + AAutoincrem + '"');
  LQryMovCar.Open;

  If LQryMovCar.IsEmpty Then
    Exit;

  LQryLogMca := fCriarQuery('SELECT * FROM LOGMCA WHERE FALSE');
  LQryLogMca.Open;

  LQryLogMca.Append;
  For I := 0 To LQryMovCar.FieldCount -1 Do
    If LQryLogMca.FindField(LQryMovCar.Fields(I).FieldName) <> Nil Then
      LQryLogMca.FieldByName(LQryMovCar.Fields(I).FieldName).Value :=
        LQryMovCar.Fields(I).Value;

  LQryLogMca.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGMCA', VS_strCodEmp);
  LQryLogMca.FieldByName('MCA_NOMFRM').AsString   := AFormulario;
  LQryLogMca.FieldByName('MCA_DESCRI').AsString   := ADescricao;
  LQryLogMca.FieldByName('MCA_DTALOG').AsDateTime := VS_Date;
  LQryLogMca.FieldByName('MCA_HORLOG').AsDateTime := fTime();
  LQryLogMca.FieldByName('MCA_OPELOG').AsString   := strLoginUsuarioLogado;
  LQryLogMca.FieldByName('MCA_NOMTAB').AsString   := 'MOVCAR';
  LQryLogMca.FieldByName('MCA_NOMEXE').AsString   := ExtractFileName(ParamStr(0));
  LQryLogMca.FieldByName('MCA_DTAEXE').Value      := Null;
  LQryLogMca.FieldByName('MCA_HOREXE').Value      := Null;
  LQryLogMca.FieldByName('MCA_VEREXE').Value      := Null;
  LQryLogMca.Post;
End;
{$ELSE }
procedure GravaLogMca(AAutoIncrem: String;
                      ADescricao,
                      ANomeFormulario: String;
                      AAutoIncremLog: String = '');
  var
    LMovCar,
    LLogMca: TUniQuery;

    LContador: Integer;

    LDataExecutavel: TDateTime;
Begin
  Try
    Try
      LMovCar := fCriarQuery('SELECT * FROM MOVCAR WHERE AUTOINCREM = "' + AAutoincrem + '"');
      LMovCar.Open;

      If LMovCar.IsEmpty Then
        Exit;

      FileAge(Application.ExeName, LDataExecutavel);

      LLogMca := fCriarQuery('SELECT * FROM LOGMCA WHERE FALSE');
      LLogMca.Open;

      LLogMca.Append;
      For LContador := 0 To LMovCar.FieldCount -1 Do
      Begin
        If LLogMca.FindField(LMovCar.Fields[LContador].FieldName) <> Nil Then
          LLogMca.FieldByName(LMovCar.Fields[LContador].FieldName).Value :=
            LMovCar.Fields[LContador].Value;
      End;

      If AAutoIncremLog.IsEmpty Then
        AAutoIncremLog := fRetAutoIncrem('LOGMCA', VS_strCodEmp);

      LLogMca.FieldByName('AUTOINCREM').AsString   := AAutoIncremLog;
      LLogMca.FieldByName('MCA_NOMFRM').AsString   := ANomeFormulario;
      LLogMca.FieldByName('MCA_DESCRI').AsString   := ADescricao;
      LLogMca.FieldByName('MCA_DTALOG').AsDateTime := VS_Date;
      LLogMca.FieldByName('MCA_HORLOG').AsDateTime := fRetHoraServidor;
      LLogMca.FieldByName('MCA_OPELOG').AsString   := strLoginUsuarioLogado;
      LLogMca.FieldByName('MCA_NOMTAB').AsString   := 'MOVCAR';
      LLogMca.FieldByName('MCA_NOMEXE').AsString   := ExtractFileName(Application.ExeName);
      LLogMca.FieldByName('MCA_DTAEXE').Value      := LDataExecutavel;
      LLogMca.FieldByName('MCA_HOREXE').Value      := EncodeTime(HourOf(LDataExecutavel),
                                                                 MinuteOf(LDataExecutavel),
                                                                 SecondOf(LDataExecutavel),
                                                                 MilliSecondOf(LDataExecutavel));

      LLogMca.FieldByName('MCA_VEREXE').AsString   := TVersaoExecutavel.GetVersaoProduto;
      LLogMca.Post;
    Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
    End;
  Finally
    If Assigned(LLogMca) Then
      FreeAndNil(LLogMca);

    If Assigned(LMovCar) Then
      FreeAndNil(LMovCar);
  End;
End;
{$ENDIF LINUX}

end.
